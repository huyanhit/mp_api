<?php
namespace App\Modules\Chat\Services;

use App\Modules\Chat\Jobs\SendMessage;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class MemberService extends ChatService
{
    use DispatchesJobs;
    public function getMembers($roomId): array
    {
        $listMember = $this->getChatRepository()->getObject('ROOM_MEMBER', $roomId);
        return array_merge($listMember, $this->getChatRepository()->getObjectsByList('MEMBER', $listMember['ROOM_MEMBER'][$roomId], $roomId));
    }

    public function getMembersByUserIds($roomId, $data): array
    {
        return $this->getChatRepository()->getObjectsByList('MEMBER', $data, $roomId);
    }

    public function addMembersIntoRoom($roomId, $members): void
    {
        DB::transaction(function () use ($roomId, $members) {
            foreach ($members as $member => $role) {
                $objectMember = $this->getChatRepository()->getObject('MEMBER', $roomId . '_' . $member);
                if (empty($objectMember['MEMBER'][$roomId . '_' . $member])) {
                    $this->getChatRepository()->addObject('MEMBER', $roomId,
                        ['type' => $role, 'position' => 1, 'room_id' => $roomId, 'user_id' => $member]
                    );
                }
            }
        });
    }

    public function updateUnread($data){
        $mention     = 0;
        $key         = $data['room_id'].'_'.Auth::id();
        $member      = $this->getChatRepository()->getObject('MEMBER', $key);
        $roomMessage = range($member['MEMBER'][$key]['position'] + 1, $data['position']);
        $messages    = $this->getChatRepository()->getObjectsByList('MESSAGE', $roomMessage, $data['room_id']);
        foreach ($messages['MESSAGE'] as $message) {
            $hasMention = $this->checkContentHasMention($data['room_id'], Auth::id(), $message['content']);
            $mention += $hasMention? 1: 0;
        }
        $data['mention'] = $member['MEMBER'][$key]['mention'];
        if($data['position'] > $member['MEMBER'][$key]['position']){
            $data['mention'] = $data['mention'] - $mention;
        }else{
            $data['mention'] = $data['mention'] + $mention;
        }

        return $this->getChatRepository()->updateObject('MEMBER', $key, $data);
    }

    public function updateMembers($roomId, $members){
        return DB::transaction(function () use ($roomId, $members) {
            $roomMember = $this->getChatRepository()->getList('ROOM_MEMBER', $roomId);
            $deletes = array_diff($roomMember, array_merge(array_keys($members), [Auth::id()]));
            $adds    = [];
            $updates = [];
            $content = '';

            foreach ($members as $member => $role) {
                if($member !== Auth::id()){
                    if (in_array($member, $roomMember)) {
                        $memberObject = $this->getChatRepository()->getObject('MEMBER', $roomId . '_' . $member);
                        if ($memberObject['MEMBER'][$roomId . '_' . $member]['type'] !== $role) {
                            $updates[] = $member;
                            $this->getChatRepository()
                                ->updateObject('MEMBER', $roomId . '_' . $member, ['type' => $role]);
                        }
                    } else {
                        $adds[] = $member;
                        $this->getChatRepository()->addObject('MEMBER', $roomId,
                            ['type' => $role, 'position' => 1, 'room_id' => $roomId, 'user_id' => $member]
                        );
                    }
                }
            }

            foreach ($deletes as $member) {
                $this->getChatRepository()->deleteObject('MEMBER', $roomId . '_' . $member);
            }

            if(!empty($adds)){
                $content .= "[room-add-member][auth:" . Auth::id() . "]".
                    "[members:" . implode('-', $adds) . "][room-add-member]";
            }
            if(!empty($updates)){
                $content .= "[room-update-member][auth:" . Auth::id() . "]".
                    "[members:" . implode('-', $updates) . "][room-update-member]";
            }
            if(!empty($deletes)){
                $content .= "[room-delete-member][auth:" . Auth::id() . "]".
                    "[members:" . implode('-', $deletes) . "][room-delete-member]";
            }

            $this->dispatchSync((new SendMessage([
                'room_id' => $roomId,
                'auth' => Auth::id(),
                'content' => $content
            ]))->onQueue('message'));

            return array_merge($adds, $updates, $deletes);
        });
    }

    public function leaveRoom($roomId, $member){
        $this->getChatRepository()->deleteObject('MEMBER', $roomId . '_' . $member);
        $content = "[room-leave-member][auth:" . Auth::id() . "][room-leave-member]";
        $this->dispatchSync((new SendMessage([
            'room_id' => $roomId,
            'auth' => Auth::id(),
            'content' => $content
        ]))->onQueue('message'));

        return [$member];
    }

    public function updateMember($key, $data){
        return $this->getChatRepository()->updateObject('MEMBER', $key, $data);
    }

    public function checkContentHasMention($roomId, $userId, $content): bool
    {
        if($this->checkContentHasMentionToAll($content)){
            return true;
        }
        if($this->checkContentHasMentionTo($roomId, $userId, $content)){
            return true;
        }

        return false;
    }

    public function checkContentHasMentionToAll($content): bool
    {
        if (preg_match('/\\[toall\\]/', $content)) {
            return true;
        }
        return false;
    }

    public function checkContentHasMentionTo($roomId, $userId, $content): bool
    {
        if (preg_match('/\\[to:' .
            $userId . '\\]|\\[reply mid:[\\d]+ to:' .
            $userId . '( rid:' . $roomId . ')*\\]/', $content)) {
            return true;
        }

        return false;
    }
}
