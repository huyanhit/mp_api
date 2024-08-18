<?php

namespace App\Traits;

use Illuminate\Http\Response;
use Illuminate\Http\UploadedFile;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Exceptions\CustomException;
use App\Repositories\Document\DocumentAttach\DocumentAttachRepositoryInterface;
use App\Repositories\Document\DocumentModuleAttach\DocumentModuleAttachRepositoryInterface;
use App\Models\Document\DocumentAttach;
use App\Modules\Document\Helpers\Helper as DocumentHelper;
use App\Helpers\Helper;
use App\Traits\FileManager;


Trait Attachment
{
    use FileManager;

    public function createAttachment(string $moduleType, Model $model)
    {
        # Nếu module chưa được khai báo trong constants.document.document_module_attach thì không cho tạo attachment
        if (!array_key_exists($moduleType, config('constants.document.document_module_attach'))) {
            throw new CustomException(__('/Document/document.module_not_defined'), Response::HTTP_BAD_REQUEST);
        }
        DB::transaction(function() use ($moduleType, $model) {
            $documentAttachRepository  =  resolve(DocumentAttachRepositoryInterface::class);
            $documentModuleAttachRepository  =  resolve(DocumentModuleAttachRepositoryInterface::class);

            $documentModuleId = $documentModuleAttachRepository->findByKey('type', $moduleType)?->id;
            if (!$documentModuleId) {
                throw new CustomException(__('/Document/document.module_not_exists'), Response::HTTP_BAD_REQUEST);
            }
            $condition = [
                'document_module_id' => $documentModuleId,
            ];
            $maxRightValue =  $documentAttachRepository->getMaxRightValueByCondition($condition)->max_right;
            $leftValue = $maxRightValue ? $maxRightValue + 1 : DocumentAttach::LEFT_VALUE_INIT;
            $rightValue = $maxRightValue ? $maxRightValue + 2 : DocumentAttach::RIGHT_VALUE_INIT;
            // Upload file
            $this->handleUploadFile($model, $documentModuleId, $rightValue, $leftValue, $moduleType);
            // Create folder
            $this->handleCreateFolder($model, $rightValue, $leftValue, $documentModuleId, $moduleType);
        });
    }

    private function prepareDataFile(array $dataInsert, string $type, UploadedFile $file, string $moduleType, string $parentPath)
    {
            $createdBy = Auth::user()->id ?? 0;
            $fileName = $file->getClientOriginalName();
            $fileName = explode('.', $fileName)[0];
            $extension = $file->getClientOriginalExtension();
            $capacity = $file->getSize();
            $mimeType = $file->getMimeType();
            $hashName = hashName($moduleType);
            $fileHashName = "$hashName." . $extension;
            $path = $parentPath . $fileHashName;
            $thumbnail = Helper::createThumbnail($extension);
            $dataInsert = array_merge(
                [
                    'name' => $fileName,
                    'hash_name' => $hashName,
                    'extension' => $extension,
                    'capacity' => $capacity,
                    'type' => $type,
                    'mime_type' => $mimeType,
                    'path' => $path,
                    'thumbnail_url' => $thumbnail,
                    'created_by' => $createdBy,
                ],
                $dataInsert
            );
        return [$dataInsert, $fileHashName];
    }

    private function prepareDataFolder(array $dataInsert, string $type, string $name, string $moduleType, string $parentPath)
    {
            $createdBy = Auth::user()->id ?? 0;
            $hashName = hashName($moduleType);
            $path = $parentPath . $hashName;
            $thumbnail = Helper::createThumbnail('folder');
            $dataInsert = array_merge(
                [
                    'name' => $name,
                    'hash_name' => $hashName,
                    'path' => $path,
                    'type' => $type,
                    'thumbnail_url' => $thumbnail,
                    'created_by' => $createdBy,
                ],
                $dataInsert
            );
        return $dataInsert;
    }

    private function handleUploadFile(Model $model, int $documentModuleId, int $rightValue, int $leftValue, string $moduleType)
    {
        if (request()->hasFile('file') && !request()->has('folder_name')) {
            foreach (request()->file('file') as $file) {
                $documentAttachRepository  =  resolve(DocumentAttachRepositoryInterface::class);
                // Tăng left_value những document có left_value >= $rightValue lên 2 đơn vị
                // Tăng right_value những document có right_value >= $rightValue lên 2 đơn vị
                $documentAttachRepository->increaseLeftRightValue($documentModuleId, $rightValue);
                $dataInsert = [
                    'left_value' => $leftValue,
                    'right_value' => $rightValue,
                    'document_module_id' => $documentModuleId,
                ];
                $parentPath = DocumentHelper::makePathAttach('', '', $moduleType, $model->id);
                [$dataPrepareInsert, $hashName] = $this->prepareDataFile($dataInsert, DocumentAttach::TYPE_FILE, $file, $moduleType, $parentPath);
                $model->documentAttachs()->create($dataPrepareInsert);
                $path = config('constants.document.path_document_attach') . 'Attachment.php/' . $parentPath;
                $this->upload($file, $path, $hashName);
                $leftValue = $leftValue + 2;
                $rightValue = $rightValue + 2;
            }
        }
    }

    private function handleCreateFolder(Model $model, int $rightValue, int $leftValue, int $documentModuleId, string $moduleType)
    {
        if (request()->has('folder_name') && !request()->hasFile('file')) {
            $dataInsert = [
                'left_value' => $leftValue,
                'right_value' => $rightValue,
                'document_module_id' => $documentModuleId,
            ];
            $parentPath = DocumentHelper::makePathAttach('', '', $moduleType, $model->id);
            $dataPrepareInsert = $this->prepareDataFolder($dataInsert, DocumentAttach::TYPE_FOLDER, request()->input('folder_name'), $moduleType, $parentPath);
            $model->documentAttachs()->create($dataPrepareInsert);
        }
    }
}
