<?php

namespace App\Modules\Chat\Jobs;

use App\Modules\Chat\Services\FileService;
use App\Modules\Chat\Services\MemberService;
use App\Modules\Chat\Services\MessageService;
use App\Modules\Chat\Services\RoomService;
use App\Services\SocketService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

use App\Traits\Notification;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class SendMessage implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, Notification;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    private array $data;
    private MessageService $messageService;
    private RoomService $roomService;
    private MemberService $memberService;
    private FileService $fileService;
    private SocketService $socketService;

    public function __construct($data){
        $this->data = $data;
    }

    public function handle(
        SocketService $socketService,
        MessageService $messageService,
        RoomService $roomService,
        FileService $fileService,
        MemberService $memberService){

        $this->socketService     = $socketService;
        $this->messageService    = $messageService;
        $this->roomService       = $roomService;
        $this->memberService     = $memberService;
        $this->fileService       = $fileService;

        if($messageId = $this->messageService->addMessage($this->data)){
            DB::transaction(function () use ($messageId){
                $lastMessage = explode('_',$messageId)[1];
                $members     = $this->roomService->getChatRepository()->getObject('ROOM_MEMBER', $this->data['room_id']);
                $hasToAll    = $this->memberService->checkContentHasMentionToAll($this->data['content']);
                $this->socketService->connect();

                if($hasToAll){
                    $this->socketService->emit([
                        'channel' => 'ROOM_' . $this->data['room_id'],
                        'event'   => 'room_to_all',
                        'data'    => $this->data['room_id']
                    ]);
                }

                $key = $this->data['room_id'].'_'.$this->data['auth'].'_lasted';
                $idLasted = Cache::has($key)? Cache::get($key): 0;
                if($idLasted == $messageId){
                    $this->memberService->updateMember(
                        $this->data['room_id'] .'_'.$this->data['auth'], [
                        'position'=> $lastMessage,
                        'mention' => 0,
                    ]);
                    $member = $this->memberService->getChatRepository()
                        ->getObject('MEMBER', $this->data['room_id'].'_'.$this->data['auth']);
                    $this->socketService->emit([
                        'channel' => 'USER_' . $this->data['auth'],
                        'event'   => 'user_update_member',
                        'data'    => $member
                    ]);
                }

                $this->roomService->updateRoom(['total' => $lastMessage], $this->data['room_id']);

                $fileInsert  = $this->messageService->processFileInContentMessage($this->data);
                $files       = $this->messageService->getChatRepository()->getObjectsByList('FILE', $fileInsert);
                $room        = $this->messageService->getChatRepository()->getObject('ROOM', $this->data['room_id']);
                $tos         = [];

                if($room['ROOM'][$this->data['room_id']]['type'] === 2){
                    $this->pushNotification('chat_thread_send', [
                        'tos'        => array_diff($members['ROOM_MEMBER'][$this->data['room_id']], [$this->data['auth']]),
                        'content'    => $this->data['content'],
                        'room_id'    => $this->data['room_id'],
                        'room_name'  => $room['ROOM'][$this->data['room_id']]['name'],
                        'position'   => $lastMessage,
                        'file_ids'   => $fileInsert
                    ]);
                }else if ($room['ROOM'][$this->data['room_id']]['type'] === 3){
                    $tos = array_diff($members['ROOM_MEMBER'][$this->data['room_id']], [$this->data['auth']]);
                }else{
                    foreach ($members['ROOM_MEMBER'][$this->data['room_id']] as $member){
                        $hasTo = $this->memberService->checkContentHasMentionTo($this->data['room_id'], $member, $this->data['content']);
                        if($hasToAll || $hasTo){
                            $keyMember  = $this->data['room_id'] .'_'. $member;
                            $object     = $this->memberService->getChatRepository()->getObject('MEMBER', $keyMember);
                            $roomMember = $object['MEMBER'][$keyMember];
                            $this->memberService->updateMember($keyMember, [
                                'mention' => $roomMember['mention'] + 1
                            ]);
                            if ($hasTo){
                                $tos[] = $member;
                                $this->socketService->emit([
                                    'channel' => 'USER_' . $member,
                                    'event'   => 'user_update_member',
                                    'data'    => $this->memberService->getChatRepository()->getObject('MEMBER', $keyMember)]
                                );
                            }
                        }
                    }

                    $tos = $hasToAll? $members['ROOM_MEMBER'][$this->data['room_id']]: $tos;
                    $tos = array_diff($tos, [$this->data['auth']]);
                }

                $r_message   = $this->messageService->getLastList('ROOM_MESSAGE', $this->data['room_id']);
                $message     = $this->messageService->getChatRepository()->getObject('MESSAGE', $messageId);

                if($tos){
                    $this->pushNotification('chat_message_send', [
                        'tos'        => $tos,
                        'content'    => $this->data['content'],
                        'room_id'    => $this->data['room_id'],
                        'room_name'  => $room['ROOM'][$this->data['room_id']]['name'],
                        'position'   => $lastMessage,
                        'file_ids'   => $fileInsert
                    ]);
                }

                $this->socketService->emit([
                    'channel' => 'ROOM_' . $this->data['room_id'],
                    'event'   => 'room_push_message',
                    'data'    => array_merge(
                        $files,
                        $room,
                        $message,
                        $r_message,
                    )
                ]);

                $this->socketService->disconnect();
            });

            return $messageId;
        }

        return null;
    }
}
