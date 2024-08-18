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
use Illuminate\Support\Facades\DB;


class UpdateMessage implements ShouldQueue
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
    private RoomService $roomService;
    private MemberService $memberService;
    private FileService $fileService;
    private SocketService $socketService;

    public function __construct($messageId, $data){
        $this->messageId = $messageId;
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

        return DB::transaction(function () {
            if ($this->messageService->updateMessage($this->messageId, $this->data)) {
                $members = $this->roomService->getChatRepository()->getObject('ROOM_MEMBER', $this->data['room_id']);
                $hasToAll = $this->memberService->checkContentHasMentionToAll($this->data['content']);
                $this->socketService->connect();
                foreach ($members['ROOM_MEMBER'][$this->data['room_id']] as $member) {
                    $hasTo = $this->memberService->checkContentHasMentionTo($this->data['room_id'], $member, $this->data['content']);
                    if ($hasToAll || $hasTo) {
                        $keyMember = $this->data['room_id'] . '_' . $member;
                        $object = $this->memberService->getChatRepository()->getObject('MEMBER', $keyMember);
                        $roomMember = $object['MEMBER'][$keyMember];
                        $this->memberService->updateMember($keyMember, [
                            'mention' => $roomMember['mention'] + 1
                        ]);
                        if ($hasTo) {
                            $this->socketService->emit([
                                'channel' => 'USER_' . $member,
                                'event' => 'user_update_member',
                                'data' => $this->memberService->getChatRepository()->getObject('MEMBER', $keyMember)]
                            );
                        }
                    }
                }

                if ($hasToAll) {
                    $this->socketService->emit([
                        'channel' => 'ROOM_' . $this->data['room_id'],
                        'event' => 'room_to_all',
                        'data' => $this->data['room_id']
                    ]);
                }

                $fileInsert = $this->messageService->processFileInContentMessage($this->data);
                $files = $this->messageService->getChatRepository()->getObjectsByList('FILE', $fileInsert);
                $result = array_merge($files,
                    $this->messageService->getChatRepository()
                        ->getObject('MESSAGE', $this->data['room_id'] . '_' . $this->messageId)
                );

                $this->socketService->emit([
                    'channel' => 'ROOM_' . $this->data['room_id'],
                    'event' => 'room_update_message',
                    'data' => $result
                ]);

                $this->socketService->disconnect();

                return $this->messageId;
            }

            return null;
        });
    }
}
