<?php

namespace App\Modules\Chat\Controllers;

use App\Exceptions\ProcessException;
use App\Http\Controllers\BaseController;
use App\Models\Chat\Message;
use App\Modules\Chat\Jobs\SendMessage;
use App\Modules\Chat\Jobs\UpdateMessage;
use App\Modules\Chat\Requests\AddMessageRequest;
use App\Modules\Chat\Requests\DeleteMessageRequest;
use App\Modules\Chat\Requests\GetMessageRequest;
use App\Modules\Chat\Requests\UpdateMessageRequest;
use App\Modules\Chat\Services\MessageService;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\JsonResponse;

class MessageController extends BaseController
{
    use DispatchesJobs;

    private MessageService $messageService;
    public function __construct(MessageService $messageService){
        $this->messageService = $messageService;
    }

    public function index(GetMessageRequest $request): JsonResponse
    {
        try {
            if($request->get('keyword')){
                return $this->sendResponse($this->messageService->searchMessages([
                    'room_id'=> $request->get('room_id'),
                    'keyword'=> $request->get('keyword')
                ]));
            }else{
                return $this->sendResponse($this->messageService->getMessages([
                    'room_id'=> $request->get('room_id'),
                    'position'=> $request->get('position'),
                    'type'=> $request->get('type')
                ]));
            }
        }catch (\Exception $e){
            throw new ProcessException($e);
        }
    }

    public function show(GetMessageRequest $request,  $id): JsonResponse
    {
        try {
            return $this->sendResponse(
                $this->messageService->getMessage([
                    'room_id'=> $request->get('room_id'),
                    'message_id'=> $id
                ])
            );
        }catch (\Exception $e){
            throw new ProcessException($e);
        }
    }

    public function store(AddMessageRequest $request): JsonResponse
    {
        try {
            $data = $request->input();
            $data['auth'] = Auth::id();
            $this->dispatchSync((new SendMessage($data))->onQueue('message'));

            return $this->sendResponse(true);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function update(UpdateMessageRequest $request, $messageId): JsonResponse
    {
        try {
            $data = $request->input();
            $data['auth'] = Auth::id();
            $this->dispatchSync((new UpdateMessage($messageId, $data))->onQueue('message'));

            return $this->sendResponse(true);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function destroy(DeleteMessageRequest $request, $messageId): JsonResponse
    {
        try {
            $data = ['room_id' => $request->room_id, 'auth' => Auth::id(), 'status'  => 0, 'content' => ""];
            $this->dispatchSync((new UpdateMessage($messageId, $data))->onQueue('message'));

            return $this->sendResponse(true);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }
}
