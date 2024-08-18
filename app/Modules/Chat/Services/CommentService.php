<?php
namespace App\Modules\Chat\Services;

use Illuminate\Support\Facades\Auth;

class CommentService extends ChatService
{
    public function getRoom($roomId)
    {
        $authId = Auth::id();
        $myRoom = ['MY_ROOM'=> [$authId => [$roomId]]];
        $rooms  = $this->getChatRepository()->getObjectsByList('ROOM', [$roomId]);
        $member = $this->getChatRepository()->getObject('MEMBER', $roomId .'_'. $authId);

        return array_merge($myRoom, $rooms, $member);
    }
}
