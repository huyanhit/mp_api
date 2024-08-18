<?php

namespace App\Modules\Chat\Jobs;

use App\Modules\Chat\Services\MessageService;
use App\Services\SocketService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;


class DeleteMessage implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    private array $data;
    private int $messageId;
    private MessageService $messageService;
    private SocketService $socketService;

    public function __construct($messageId, $data){
        $this->messageId = $messageId;
        $this->data = $data;
    }

    public function handle(SocketService $socketService, MessageService $messageService){

        $this->socketService     = $socketService;
        $this->messageService    = $messageService;

        if($messageId = $this->messageService->deleteMessage($this->messageId, $this->data)){
            $this->socketService->send([
                'channel' => 'ROOM_' . $this->data['room_id'],
                'event'   => 'room_update_message',
                'data'    => $this->messageService->getChatRepository()->getObject('MESSAGE', $messageId)
            ]);

            return $messageId;
        }

        return null;
    }
}
