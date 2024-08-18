<?php
namespace App\Helpers;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\Eloquent\Builder;
use Spatie\Permission\Models\Permission;
use App\Traits\FileManager;

class Helper{

    use FileManager;

    public static function trackingError($params)
    {
        $module = $params['module'];
        $action = $params['action'];
        $msg_log = $params['msg_log'];

        $host = request()->getHost();
        $subDomain = getSubDomain($host);
        if($action==null){
            $action = request()->route()->getActionMethod() ?? "undefine";
        }
        config([
            'logging.channels.' . $subDomain. '_error' => [
                'driver' => 'daily',
                'path' => storage_path("logs/".$subDomain."/custom_error/custom_error.log"),
                'level' => 'error',
                'days' => 365
            ]
        ]);

        Log::channel($subDomain. '_error')->error($module.'_'.$action.":".$msg_log);
    }

    public static function trackingInfo($params)
    {
        $module = $params['module'];
        $action = $params['action'];
        $msg_log = $params['msg_log'];

        $host = request()->getHost();
        $subDomain = getSubDomain($host);
        if($action==null){
            $action = request()->route()->getActionMethod() ?? "undefine";
        }

        config([
            'logging.channels.' . $subDomain. '_info' => [
                'driver' => 'daily',
                'path' => storage_path("logs/".$subDomain."/custom_info/custom_info.log"),
                'level' => 'info',
                'days' => 365
            ]
        ]);

        Log::channel($subDomain. '_info')->info($module.'_'.$action.":".$msg_log);
    }


    public static function getQueries(Builder $builder)
    {
        $addSlashes = str_replace('?', "'?'", $builder->toSql());
        return vsprintf(str_replace('?', '%s', $addSlashes), $builder->getBindings());
    }

    public static  function permissions()
    {
        // separate to groups
        $groups = [
            [
                'group_key' => 'user',
                'group_name' => 'Tài khoản',
                'active' => true,
                'modules' => [
                    [
                        'module_key' => 'employee',
                        'module_name' => 'Nhân viên',
                        'active' => true,
                        'permissions' => [
                            ['name' => 'view_user', 'name_string' => 'Xem', 'description' => 'Xem', 'module_key' => 'employee', 'module_name' => 'Nhân viên', 'guard_name' => 'api', 'sort' => 1, 'is_active' => true],
                            ['name' => 'create_user', 'name_string' => 'Tạo', 'description' => 'Tạo', 'module_key' => 'employee', 'module_name' => 'Nhân viên', 'guard_name' => 'api', 'sort' => 2, 'is_active' => true],
                            ['name' => 'edit_user', 'name_string' => 'Sửa', 'description' => 'Sửa', 'module_key' => 'employee', 'module_name' => 'Nhân viên', 'guard_name' => 'api', 'sort' => 3, 'is_active' => true],
                            ['name' => 'delete_user', 'name_string' => 'Xoá', 'description' => 'Xoá', 'module_key' => 'employee', 'module_name' => 'Nhân viên', 'guard_name' => 'api', 'sort' => 4, 'is_active' => true],
                        ]
                    ],
                    [
                        'module_key' => 'role',
                        'module_name' => 'Vai trò',
                        'active' => true,
                        'permissions' => [
                            ['name' => 'view_role', 'name_string' => 'Xem', 'description' => 'Xem', 'module_key' => 'role', 'module_name' => 'Vai trò', 'guard_name' => 'api', 'sort' => 1, 'is_active' => true],
                            ['name' => 'create_role', 'name_string' => 'Tạo', 'description' => 'Tạo', 'module_key' => 'role', 'module_name' => 'Vai trò', 'guard_name' => 'api', 'sort' => 2, 'is_active' => true],
                            ['name' => 'edit_role', 'name_string' => 'Sửa', 'description' => 'Sửa', 'module_key' => 'role', 'module_name' => 'Vai trò', 'guard_name' => 'api', 'sort' => 3, 'is_active' => true],
                            ['name' => 'delete_role', 'name_string' => 'Xoá', 'description' => 'Xoá', 'module_key' => 'role', 'module_name' => 'Vai trò', 'guard_name' => 'api', 'sort' => 4, 'is_active' => true],
                        ]
                    ],
                ]
            ],
        ];

        return $groups;
    }


    public static  function generatePermissions(array $groups)
    {
        foreach ($groups as $group){
            foreach ($group['modules'] as $module) {
                foreach ($module['permissions'] as $permission) {
                    Permission::firstOrCreate($permission);
                }
            }
        }
    }

    # Sử dụng sendResponse cho Service
    public static function sendResponse($result, $message)
    {
        $response = [
            'success' => true,
            'data'    => $result,
            'message' => $message,
        ];

        return response()->json($response, 200);
    }

    # Sử dụng sendError cho Service
    public static function sendError($error, $errorMessages, $code = 404)
    {
        $response = [
            'success' => false,
            'data'    => [],
        ];

        if($errorMessages != null){
            $response['message'] = $errorMessages;
        }else{
            $bagError = new \Illuminate\Support\MessageBag;
            $bagError->add('exception', $error);
            $response['message'] = $bagError;
        }

        return response()->json($response, $code);
    }

    public static function uploadFile(UploadedFile $file, string $path, string|null $disk = '')
    {
        $hashName = hashName();
        $extension = $file->getClientOriginalExtension();
        $newName = "$hashName.$extension";
        # Call function upload from trait FileManager
        (new self)->upload($file, $path, $newName, $disk);
        $thumbnail = self::createThumbnail($extension);
        return [
            'path' => $path . '/' . $newName,
            'file_name' => $file->getClientOriginalName(),
            'hash_name' => $newName,
            'extension' => $extension,
            'mime_type' => $file->getClientMimeType(),
            'size' => $file->getSize(),
            'thumbnail_url' => $thumbnail,
        ];
    }

    # Lấy danh sách tất cả các module của hệ thống
    public static function allModules()
    {
        return array_map('basename', File::directories(__DIR__ . '/../Modules/'));
    }

    public static function createThumbnail(string $extension) {
        $url = '';
        switch ($extension) {
            case 'png':
            case 'jpg':
            case 'jpeg':
                $url = asset('images/thumbnails/image.png');
                break;
            case 'docx':
            case 'doc':
                $url = asset('images/thumbnails/doc.png');
                break;
            case 'xls':
            case 'xlsx':
                $url = asset('images/thumbnails/excel.png');
                break;
            case 'pdf':
                $url = asset('images/thumbnails/pdf.png');
                break;
            case 'mp3':
            case 'mp4':
                $url = asset('images/thumbnails/media.png');
                break;
            case 'folder':
                $url = asset('images/thumbnails/folder.svg');
            default:
                $url = asset('images/thumbnails/document.png');
                break;
        }
        return $url;
    }

    public static function getAssetUrl(string $path, string|null $disk = '', array $options = [] , string|null $expiration = '')
    {
        if ($disk === 's3') {
            $configExpiresS3 = config('constants.document.expires_url');
            $expiration = $expiration ? $expiration : $configExpiresS3;
            return generationTempUrlS3($path, $expiration, $options);
        }
        return getAssetStorageLocal($path);
    }
}
