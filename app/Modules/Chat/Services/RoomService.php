<?php
namespace App\Modules\Chat\Services;

use App\Modules\Chat\Jobs\SendMessage;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class RoomService extends ChatService
{
    use DispatchesJobs;
    public function getMyRooms(): array
    {
        return $this->getChatRepository()->getObject('MY_ROOM', Auth::id());
    }

    public function getAllRoom()
    {
        $orders['MEMBER']  = [];
        $orders['MESSAGE'] = [];

        $authId     = Auth::id();
        $myRoom     = $this->getChatRepository()->getObject('MY_ROOM', $authId);
        $rooms      = $this->getChatRepository()->getObjectsByList('ROOM', $myRoom['MY_ROOM'][$authId]);
        $hasPRoom   = false;

        foreach ($rooms['ROOM'] as $room){
            if($room['type'] === 4) $hasPRoom = true;
            $member  = $this->getChatRepository()->getObject('MEMBER', $room['id'] .'_'. $authId);
            $orders['MEMBER']  = array_merge($member['MEMBER'], $orders['MEMBER']);
            if($room['total'] > 0){
                $message = $this->getChatRepository()->getObject('MESSAGE', $room['id']  .'_'. $room['total']);
                $orders['MESSAGE'] = array_merge($message['MESSAGE'], $orders['MESSAGE']);
            }
        }

        if(!$hasPRoom) {
            $this->createMyChat($myRoom, $rooms, $orders);
        }

        return array_merge($myRoom, $rooms, $orders);
    }

    public function getRoomInfo($roomId): array
    {
        $response = $this->getChatRepository()->getPageList('ROOM_FILE', $roomId, 1, true);
        $roomFile = ['ROOM_FILE' => [$roomId => $response['list'], 'total_page_'.$roomId => $response['total_page']]];
        return array_merge($roomFile, $this->getChatRepository()->getObjectsByList('FILE', $roomFile['ROOM_FILE'][$roomId]));
    }

    public function addRoom($data, $type = 1){
         return DB::transaction(function () use ($data, $type) {
            $roomId = $this->getChatRepository()->addObject('ROOM', null, array_merge($data, ['type' => $type]));
            $this->getChatRepository()->addObject('MEMBER', $roomId,
                ['type' => 2, 'position' => 1, 'room_id' => $roomId, 'user_id' => Auth::id()]
            );

            return $roomId;
        });
    }

    public function addModuleRoom($data, $module){
        return $this->getChatRepository()->addObject('MODULE_ROOM', $module, $data);
    }

    public function updateRoom($data, $roomId){
        unset($data['members']);
        return $this->getChatRepository()->updateObject('ROOM', $roomId, $data);
    }

    public function deleteRoom($roomId){
        return $this->getChatRepository()->deleteObject('ROOM', $roomId);
    }

    private function createMyChat(&$myRoom, &$rooms, &$orders)
    {
        DB::transaction(function () use (&$myRoom, &$rooms, &$orders) {
            $roomId = $this->getChatRepository()->addObject('ROOM', null,
                array_merge(['type' => 4, 'name' => 'My Chat', 'description' => 'My Chat']));
            $memberKey = $this->getChatRepository()->addObject('MEMBER', $roomId,
                ['type' => 2, 'position' => 1, 'room_id' => $roomId, 'user_id' => Auth::id()]
            );
            $room = $this->getChatRepository()->getObject('ROOM', $roomId);
            $member = $this->getChatRepository()->getObject('MEMBER', $memberKey);
            $rooms['ROOM'][$roomId] = $room['ROOM'][$roomId];
            $orders['MEMBER'][$memberKey] = $member['MEMBER'][$memberKey];
            array_unshift($myRoom['MY_ROOM'][Auth::id()], $roomId);

            $this->dispatchSync((new SendMessage([
                'room_id' => $roomId,
                'auth' => Auth::id(),
                'content' => "[room-create][auth:" . Auth::id() . "][room:" . $roomId . "][room-create]"
            ]))->onQueue('message'));
        });
    }
}
