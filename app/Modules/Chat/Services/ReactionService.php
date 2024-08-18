<?php
namespace App\Modules\Chat\Services;

use App\Services\SocketService;

class ReactionService extends ChatService
{
    public function addReaction($request)
    {
        $key = $request['room_id'].'_'.$request['message_id'];
        if($id = $this->checkReactionExists($request)){
            $this->chatRepository->deleteObject('REACTION', $key .'_'. $id);
        }else{
            $key = $this->chatRepository->addObject('REACTION', $key,
                ['room_id' => $request['room_id'], 'message_id' => $request['message_id'],
                 'user_id' => $request['user_id'], 'emoji_id' => $request['emoji_id']]);
        }

        $messageReaction = $this->chatRepository->getList('MESSAGE_REACTION',$key);
        $socketService = new SocketService();
        $socketService->send([
            'channel' => 'ROOM_' . $request['room_id'],
            'event' => 'room_update_reaction',
            'data' => array_merge($this->chatRepository->getObject('REACTION', $key),
                ['MESSAGE_REACTION' => [$request['room_id'].'_'.$request['message_id'] => $messageReaction]])
        ]);

        return true;
    }

    private function checkReactionExists($request): int
    {
        $key = $request['room_id'].'_'.$request['message_id'];
        $messageReaction = $this->chatRepository->getList('MESSAGE_REACTION', $key);
        $list = $this->chatRepository->getObjectsByList('REACTION', $messageReaction, $key);
        foreach ($list['REACTION'] as $reaction){
            if($reaction['emoji_id'] == $request['emoji_id'] && $reaction['user_id'] == $request['user_id']){
                return $reaction['id'];
            }
        }

        return false;
    }
}
