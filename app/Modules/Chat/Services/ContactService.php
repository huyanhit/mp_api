<?php
namespace App\Modules\Chat\Services;

use App\Models\Chat\Contact;
use App\Models\User;
use App\Modules\Chat\Jobs\SendMessage;
use App\Services\SocketService;
use App\Traits\Notification;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ContactService extends ChatService
{
    use Notification, DispatchesJobs;

    public function getAllGuest(): array
    {
        $userId    = Auth::id();
        $myContact = $this->getChatRepository()->getObject('MY_CONTACT', $userId);
        $myUser    = $this->getChatRepository()->getObject('MY_USER', $userId);
        $myUser    = array_merge([$userId], $myUser['MY_USER'][$userId], $myContact['MY_CONTACT'][$userId]);

        return ['GUEST'  => User::whereNotIn('id', $myUser)->get()->keyBy('id')];
    }

    public function getAllContact($userId): array
    {
        $myContact = $this->getChatRepository()->getObject('MY_CONTACT', $userId);
        $myUser    = $this->getChatRepository()->getObject('MY_USER', $userId);
        $myUser    = array_merge([$userId], $myUser['MY_USER'][$userId], $myContact['MY_CONTACT'][$userId]);
        $contacts  = Contact::where('user_id', $userId)->get();
        $contacts  = $contacts->merge(Contact::where('contact_id', $userId)->get());

        $listUser  = User::find($myUser);
        return array_merge(
            ['CONTACT' => $contacts->keyBy(function ($item) use ($userId){
                return $item->user_id === $userId? $item->contact_id: $item->user_id;
            })],
            ['MY_USER' => [$userId => $myUser]],
            ['USER'    => $listUser->keyBy('id')],
        );
    }

    public function getUser($type)
    {
        $authId = Auth::id();
        if ($type == 'unfriend') {
            $users = Contact::where('user_id', $authId)->get();
            $contacts = Contact::where('contact_id', $authId)->get();
            $ids = array_merge($users->pluck('contact_id')->toArray(), $contacts->pluck('user_id')->toArray());

            return ['UNFRIEND' => User::where('id', '!=', $authId)->whereNotIn('id', $ids)->get()->keyBy('id')];
        }
        if($type == 'approve'){
            $requested = Contact::where(['contact_id' => $authId, 'requested'=> '1'])->get();
            $ids = $requested->pluck('user_id');

            return ['APPROVE' => User::where('id', '!=', $authId)->whereIn('id', $ids)->get()->keyBy('id')];
        }
        if($type == 'requested'){
            $requested = Contact::where(['user_id' => $authId, 'requested'=> '1'])->get();
            $ids = $requested->pluck('contact_id');

            return ['REQUESTED' => User::where('id', '!=', $authId)->whereIn('id', $ids)->get()->keyBy('id')];
        }

        return null;
    }

    public function addContact($data): array
    {
        return DB::transaction(function () use ($data){
            $socketService = new SocketService();
            $socketService->connect();
            $authId = Auth::id();
            foreach (User::find($data['ids']) as $user) {
                $this->getChatRepository()->addObject('CONTACT', null, [
                    'user_id' => $authId, 'contact_id' => $user->id, 'requested' => 1,
                ]);
                $socketService->emit([
                    'channel' => 'USER_' . $user->id,
                    'event' => 'user_add_contact',
                    'data' => [
                        'APPROVE' => [$authId => User::find($authId)],
                        'UNFRIEND' => [$authId => null]
                    ]
                ]);

            }
            $socketService->disconnect();
            $this->pushNotification('chat_add_contact', [
                'tos' => $data['ids'],
                'contact_id' => $authId
            ]);

            return $data['ids'];
        });
    }

    public function approve($data): array
    {
        $results = DB::transaction(function () use ($data) {
            $results = [];
            foreach ($data['ids'] as $id) {
                $authId = Auth::id();
                $key    = $id . '_' . $authId;

                // create direct room
                $roomId = $this->getChatRepository()->addObject('ROOM', null,
                    ['type' => 3, 'name' => 'direct', 'description' => 'direct room']);
                $this->getChatRepository()->addObject('MEMBER', $roomId,
                    ['type' => 1, 'position' => 1, 'room_id' => $roomId, 'user_id' => $authId]
                );
                $this->getChatRepository()->addObject('MEMBER', $roomId,
                    ['type' => 1, 'position' => 1, 'room_id' => $roomId, 'user_id' => $id]
                );

                // update contact
                $this->getChatRepository()->updateObject('CONTACT', $key, [
                    'requested' => 2, 'room_id' => $roomId,
                ]);

                // send message
                $this->dispatchSync((new SendMessage([
                    'room_id' => $roomId,
                    'auth' => $authId,
                    'content' => "[room-create][auth:" . $authId . "][room:" . $roomId . "][room-create]".
                        "[room-add-member][auth:" . Auth::id() . "][members:".$authId."-".$id."][room-add-member]"
                ]))->onQueue('message'));

                $results[] = ['room_id'=> $roomId, 'user_id'=> $id];
            }
            // push notification
            $this->pushNotification('chat_approve_contact', ['tos' => $data['ids']]);

            return $results;
        });

        if($results){
            $socketService = new SocketService();
            $socketService->connect();
            foreach ($results as $item){
                $room       = $this->getChatRepository()->getObject('ROOM', $item['room_id']);
                $roomMember = $this->getChatRepository()->getObject('ROOM_MEMBER', $item['room_id']);
                $members    = $this->getChatRepository()->getObjectsByList('MEMBER', $roomMember['ROOM_MEMBER'][$item['room_id']], $item['room_id']);
                $socketService->emit([
                    'channel' => 'USER_' . Auth::id(),
                    'event' => 'user_approve_contact',
                    'data' => array_merge(
                        $room,
                        $roomMember,
                        $members,
                        $this->getChatRepository()->getObject('MY_ROOM', Auth::id()),
                        $this->getAllContact(Auth::id()),
                    )
                ]);
                $socketService->emit([
                    'channel' => 'USER_' . $item['user_id'],
                    'event' => 'user_approve_contact',
                    'data' => array_merge(
                        $room,
                        $members,
                        $roomMember,
                        $this->getChatRepository()->getObject('MY_ROOM', $item['user_id']),
                        $this->getAllContact($item['user_id']),
                        ['REQUESTED' => [Auth::id() => null]]
                    )
                ]);
            }

            $socketService->disconnect();
        }

        return $results;
    }

    public function cancel($data): array
    {
        return DB::transaction(function () use ($data) {
            $socketService = new SocketService();
            $socketService->connect();
            $authId = Auth::id();
            foreach ($data['ids'] as $id) {
                $this->getChatRepository()->deleteObject('CONTACT', $id . '_' . $authId);
                $socketService->emit([
                    'channel' => 'USER_' . $id,
                    'event' => 'user_cancel_contact',
                    'data' => [
                        'REQUESTED' => [$authId => null]
                    ]
                ]);
            }
            $socketService->disconnect();

            return $data['ids'];
        });
    }

    public function unRequest($data): array
    {
        return DB::transaction(function () use ($data) {
            $socketService = new SocketService();
            $socketService->connect();
            $authId = Auth::id();
            foreach ($data['ids'] as $id) {
                $this->getChatRepository()->deleteObject('CONTACT', $authId . '_' . $id);
                $socketService->emit([
                    'channel' => 'USER_' . $id,
                    'event' => 'user_un_request_contact',
                    'data' => [
                        'APPROVE' => [$authId => null]
                    ]
                ]);
            }
            $socketService->disconnect();

            return $data['ids'];
        });
    }

    public function remove($data): array
    {
        $ids = DB::transaction(function () use ($data) {
            $authId = Auth::id();
            foreach ($data['ids'] as $id) {
                $key = '';
                $contact = null;
                $contactObject  = $this->getChatRepository()->getObject('CONTACT', $authId . '_' . $id);
                $contactObject2 = $this->getChatRepository()->getObject('CONTACT', $id . '_' . $authId);
                if(!empty($contactObject['CONTACT'][$authId . '_' . $id])){
                    $key = $authId . '_' . $id;
                    $contact = $contactObject['CONTACT'][$key];
                }else if(!empty($contactObject2['CONTACT'][$id . '_' . $authId])){
                    $key = $id . '_' . $authId;
                    $contact = $contactObject2['CONTACT'][$key];
                }
                if (!empty($contact)){
                    $this->getChatRepository()->deleteObject('CONTACT', $key);
                    if(!empty($contact['room_id'])){
                        $this->getChatRepository()->deleteObject('ROOM', $contact['room_id']);
                        $this->getChatRepository()->deleteObject('MEMBER', $contact['room_id'].'_'.$authId);
                        $this->getChatRepository()->deleteObject('MEMBER', $contact['room_id'].'_'.$id);
                    }
                }
            }

            return $data['ids'];
        });

        if(!empty($ids)){
            $socketService = new SocketService();
            $socketService->connect();
            foreach ($ids as $id) {
                $socketService->emit([
                    'channel' => 'USER_' . Auth::id(),
                    'event' => 'user_remove_contact',
                    'data' => array_merge(
                        $this->getChatRepository()->getObject('MY_ROOM', Auth::id()),
                        $this->getAllContact(Auth::id()),
                    )
                ]);
                $socketService->emit([
                    'channel' => 'USER_' . $id,
                    'event' => 'user_remove_contact',
                    'data' => array_merge(
                        $this->getChatRepository()->getObject('MY_ROOM', $id),
                        $this->getAllContact($id)
                    )
                ]);
            }

            $socketService->disconnect();
        }

        return $ids;
    }
}
