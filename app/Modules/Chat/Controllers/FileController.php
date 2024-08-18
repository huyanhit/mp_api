<?php

namespace App\Modules\Chat\Controllers;

use App\Exceptions\GetImageException;
use App\Exceptions\ProcessException;
use App\Exceptions\UploadException;
use App\Http\Controllers\BaseController;
use App\Modules\Chat\Requests\RemoveFileRequest;
use App\Modules\Chat\Requests\UploadFileRequest;
use App\Modules\Chat\Services\FileService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class FileController extends BaseController {
    private FileService $fileService;
    public function __construct(FileService $fileService){
        $this->fileService = $fileService;
    }

    public function getFileThumbnail($fileId){
        try {
            return $this->fileService->getFileThumbnail($fileId);
        }catch (\Exception $e){
            throw new GetImageException($e);
        }
    }

    public function getFileRaw($fileId){
        try {
            return $this->fileService->getFileRaw($fileId);
        }catch (\Exception $e){
            throw new GetImageException($e);
        }
    }

    public function index(Request $request): JsonResponse
    {
        try {
            $roomId = $request->get('room_id');
            if(!empty($roomId)){
                return $this->sendResponse($this->fileService->getRoomFile($roomId, $request->get('page')));
            }else{
                return $this->sendResponse($this->fileService->getMyFile($request->get('page')));
            }
        }catch (\Exception $e){
            throw new ProcessException($e);
        }
    }

    public function store(UploadFileRequest $request): JsonResponse
    {
        try {
            $fileKeys = $this->fileService->uploadFiles($request->all());
            $objectFiles = array_merge(
                $this->fileService->getLastListMyFile(1),
                $this->fileService->getLastListRoomFile($request->get('room_id'), 1),
                $this->fileService->getChatRepository()->getObjectsByList('FILE', $fileKeys)
            );

            return $this->sendResponse($objectFiles);
        }catch (\Exception $e){
            throw new UploadException($e);
        }
    }

    public function destroy($fileId): JsonResponse
    {
        try {
            $this->fileService->deleteFile($fileId);
            return $this->sendResponse(['FILE'=>[$fileId => null]],'remove room success');
        }catch (\Exception $e){
            throw new ProcessException($e);
        }
    }
}
