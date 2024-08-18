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
use Illuminate\Support\Facades\Auth;
use App\Traits\Notification;

class SendThread implements ShouldQueue
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

        if($threadId = $this->messageService->addThread($this->data)){
            $fileInsert  = $this->messageService->processFileInContentMessage($this->data);
            $files       = $this->messageService->getChatRepository()->getObjectsByList('FILE', $fileInsert);
            $thread      = $this->messageService->getChatRepository()->getObject('THREAD', $threadId);
            $result = array_merge($files, $thread,
                $this->messageService->getLastList('MESSAGE_THREAD', $this->data['thread']),
            );

            $this->socketService->send([
                'channel' => 'ROOM_' . $this->data['room_id'],
                'event'   => 'room_push_thread',
                'data'    => $result
            ]);

            $this->pushNotification('chat_thread_send', [
                'content'  => $this->data['content'],
                'room_id'  => $threadId,
                'room_name'=> $thread['THREAD'][$threadId]['name'],
                'file_ids' => $fileInsert
            ]);

            return $threadId;
        }

        return null;
    }
}
