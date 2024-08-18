<?php

    use Carbon\Carbon;
    use Illuminate\Support\Facades\File;
    use Illuminate\Support\Facades\Config;
    use Illuminate\Support\Facades\Storage;
    use Illuminate\Support\Str;
    use Log\Log;

    if (!function_exists('randomNumber')) {
        function randomNumber($size = 10)
        {
            $characters = '0123456789';
            $randomString = '';
            for ($i = 0; $i < $size; $i++) {
                $index = rand(0, strlen($characters) - 1);
                $randomString .= $characters[$index];
            }
            return $randomString;
        }
    }

    if (!function_exists('mbTrim')) {
        function mbTrim($value, $chars = '\s　')
        {
            $value = preg_replace("/^[$chars]+/u", '', $value);
            $value = preg_replace("/[$chars]+$/u", '', $value);
            return $value;
        }
    }

    if (!function_exists('getAction')) {
        function getAction($module,$action=null)
        {
            if($action==null){
                $action = request()->route()->getActionMethod() ?? "undefine";
            }
            return $module.'_'.$action;
        }
    }

    if (!function_exists('convertDateString')) {
        function convertDateString($dateString)
        {
            return Str::replace('-', '/', Str::substr($dateString, 5));
        }
    }

    if (!function_exists('hashFileName')) {
        function hashFileName($fileName)
        {
            $arr_part = explode('.',$fileName);
            $extension = end($arr_part);
            return randomNumber().'_'.date('YmdHis').'_'.time().'.'.$extension;
        }
    }

    if (!function_exists('getPortal')) {
        function getPortal()
        {
            try {
                $siteName = 'main'; 
                $host = request()->getHost();
                if ($host != env('MAIN_DOMAIN')) {
                    $siteName = explode('.', $host)[0];
                }
            } catch (\Throwable $th) {
                $siteName = 'main'; 
            }
            return $siteName;
        }
    }

    if (!function_exists('makeFolder')) {
        function makeFolder(string|null $pathFolder, $disk = '')
        {
            $diskConfig = $disk ?? config('constants.document.disk_document');
            $parentDir = 'uploads';
            return Storage::disk($diskConfig)->makeDirectory($parentDir . '/' . getPortal() . '/' . $pathFolder);
        }
    }

    if (!function_exists('getPathFolder')) {
        function getPathFolder($pathFolder)
        {
            $parentDir = 'uploads';
            return $parentDir.'/' . getPortal() . "/" . $pathFolder;
        }
    }

    if (!function_exists('getFullPathFolder')) {
        function getFullPathFolder(string|null $pathFolder, $disk = '')
        {
            $diskConfig = $disk ?? config('constants.document.disk_document');
            $parentDir = 'uploads';
            if ($diskConfig == 's3') {
                return Storage::disk($diskConfig)->url($parentDir.'/' . getPortal() . "/" . $pathFolder);
            } else {
                return Storage::disk($diskConfig)->path($parentDir.'/' . getPortal() . "/" . $pathFolder);
            }
        }
    }

    if (!function_exists('existPathFolder')) {
        function existPathFolder($pathFolder, $disk = '')
        {
            $parentDir = 'uploads';
            $disk = $disk ?? config('constants.document.disk_document');
            return Storage::disk($disk)->exists($parentDir . '/' . getPortal() . '/' . $pathFolder);
        }
    }

    if (!function_exists('makeTempFolder')) {
        function makeTempFolder(string|null $pathFolder, $disk = '') {
            $parentDir = 'temp';
            $disk = $disk ?? 'local';
            return Storage::disk($disk)->makeDirectory($parentDir . '/' . getPortal() . '/' . $pathFolder);
        }
    }

    if (!function_exists('getPathTempFolder')) {
        function getPathTempFolder($pathFolder){
            $parentDir = 'temp';
            return $parentDir.'/' . getPortal() . "/" . $pathFolder;
        }
    }

    if (!function_exists('getAssetFolder')) {
        function getAssetFolder($publicFolder)
        {
            $parentDir = 'uploads';
            return asset($parentDir.'/'. getPortal() . "/" . $publicFolder);
        }
    }

    if (!function_exists('getAssetStorageLocal')) {
        function getAssetStorageLocal($publicFolder)
        {
            $parentDir = 'storage';
            return asset($parentDir.'/'. getPortal() . "/" . $publicFolder);
        }
    }

    if (!function_exists('generationTempUrlS3')) {
        function generationTempUrlS3(string|null $pathFolder, string $expiresTime, array $headers) {
            $parentDir = 'uploads';
            return Storage::disk('s3')->temporaryUrl($parentDir . '/' . getPortal() . '/' . $pathFolder, $expiresTime, $headers);
        }
    }

    if(!function_exists('moneyFormat')){
        function moneyFormat($str){
            $num = 0;
            $num = number_format($str, 0, '.', ',');
            return $num;
        }
    }

    if (!function_exists('dateNowDash')) {
        function dateNowDash()
        {
            return date('Y-m-d');
        }
    }

    if (!function_exists('dateNow')) {
        function dateNow()
        {
            return date('Y-m-d H:i:s');
        }
    }

    if (!function_exists('dayNow')) {
        function dayNow()
        {
            return date('Y/m/d');
        }
    }

    if (!function_exists('getControllerName')) {
        function getControllerName($string) {
            $pices = explode('\\', $string);
            $pices1 = explode('@', end($pices));
            $controller_name = current($pices1);
            return $controller_name;
        }
    }

    if (!function_exists('formatNumber')) {
        function formatNumber($number, $type=null){
            try {
                if(($type==null  && is_int($number)) || $type == 'int') {
                    return number_format($number, 0, '', ',');
                }
                else {
                    return number_format($number, 2, '.', ',');
                }
            } catch (\Throwable $th) {
                return $number;
            }
        }
    }

    if (!function_exists('mbConvertEncoding')) {
        function mbConvertEncoding($str)
        {
            try {
                $content_converted = mb_convert_encoding($str, "UTF-8",
                "Shift-JIS, EUC-JP, JIS, SJIS, JIS-ms, eucJP-win, SJIS-win, ISO-2022-JP,
                ISO-2022-JP-MS, SJIS-mac, SJIS-Mobile#DOCOMO, SJIS-Mobile#KDDI,
                SJIS-Mobile#SOFTBANK, UTF-8-Mobile#DOCOMO, UTF-8-Mobile#KDDI-A,
                UTF-8-Mobile#KDDI-B, UTF-8-Mobile#SOFTBANK, ISO-2022-JP-MOBILE#KDDI");
                return $content_converted;
            } catch (\Throwable $e) {
                return null;
            }
        }
    }

    if (!function_exists('getExtFile')) {
        function getExtFile($file_name)
        {
            if($file_name != null){
                $parts = explode('.', $file_name);
                $extension = end($parts);
                return $extension;
            }else{
                return '';
            }

        }
    }

    if (!function_exists('siteMain')) {
        function siteMain()
        {
            $siteMain  = env('MAIN_DOMAIN');
            $hostName = request()->getHost();
            if($hostName == $siteMain) {
                return true;
            }
            return false;
        }
    }

    if (!function_exists('getSubDomain')) {
        function getSubDomain($hostName)
        {
            $domain   = env('MAIN_DOMAIN');
            $subDomain = $hostName != $domain ? str_replace("." . $domain, "", $hostName) : 'main';
            return $subDomain;
        }
    }

    if(!function_exists('configConnection')){
        function configConnection($database){
            Config::set(["database.connections.$database" => [
                'driver' => 'pgsql',
                'url' => env('DATABASE_URL'),
                'host' => env('DB_HOST', '127.0.0.1'),
                'port' => env('DB_PORT', '5432'),
                'database' => $database,
                'username' => env('DB_USERNAME', 'forge'),
                'password' => env('DB_PASSWORD', ''),
                'charset' => 'sql_ascii',
                'prefix' => '',
                'prefix_indexes' => true,
                'schema' => 'public',
                'sslmode' => 'prefer',
            ]]);
        }
    }

    if(!function_exists('hashName')) {
        function hashName(string $prefix = '')
        {
            return ($prefix ? $prefix . '_' : '') . date('ymd') . "_" . randomNumber(20);
        }
    }

    if (!function_exists('diffDays')) {
        function diffDays($startDate, $endDate)
        {
            $start = \Carbon\Carbon::parse($startDate);
            $end = \Carbon\Carbon::parse($endDate);

            return ($start->diffInDays($end) + 1);
        }
    }

    # Hàm tạo table tạm để sử dụng PostgreSQL CTE
    if (!function_exists('createTempTable')) {
        function createTempTable($data){
            if (count($data) > 0) {
                $key = implode(",", array_keys($data[0]));
                $sql = "WITH temp(" . $key . ") as ( values ";
                foreach ($data as $key => $value) {
                    if (count($value) == 0) continue;
                    $sub = "(";
                    foreach ($value as $key => $col) {
                        if (gettype($col) === "string") {
                            $col = "'" . addslashes($col) . "'";
                        }
                        $sub = $sub . $col . ",";
                    }
                    $sub = trim($sub, ',');
                    $sub = $sub . '),';
                    $sql = $sql . $sub;
                }
                $sql = trim($sql, ',') . "),";
                return $sql;
            }
        }
    }

    # Lấy thông tin chi tiết ngoại lệ trả về
    if (!function_exists('getMessage')) {
        function getMessage($e)
        {
            try {
                $message = PHP_EOL;
                $message .= "Message: ".$e->getMessage() .PHP_EOL;
                $message .= "File: ".$e->getFile() .PHP_EOL;
                $message .= "Line: ".$e->getLine() .PHP_EOL;
                $message .= "Params: ".request()->getQueryString() .PHP_EOL;
                return $message; 
            } catch (\Throwable $e) {
                return null;
            }
        }
    }

    if(!function_exists('parseDate')){
        function parseDate($date)
        {
            try {
                return isset($date) ? Carbon::parse($date)->format('Y-m-d') : null;
            } catch (\Throwable $e) {
                return null;
            }
        }
    }

    if(!function_exists('urlAvatar')){
        function urlAvatar($image)
        {
            try {
                return !empty($image) ? asset('avatars/' . $image) : asset('images/default_avatar.png');
            } catch (\Throwable $e) {
                return asset('images/default_avatar.png');
            }
        }
    }

    # Hàm log câu truy vấn sql
    if(!function_exists('logQuery')){
        function logQuery($query)
        {
            Log::info($query->toSql());
        }
    }

    # Hàm hiển thị câu truy vấn
    if(!function_exists('getQuery')){
        function getQuery($query)
        {
            $addSlashes = str_replace('?', "'?'", $query->toSql());
            return vsprintf(str_replace('?', '%s', $addSlashes), $query->getBindings());
        }
    }

    # Hàm lấy path url từ sau api/v1
    if(!function_exists('getSortPath')){
        function getSortPath(string $url)
        {
            $url = explode('api/v1/', $url);
            return $url[1];
        }
    }

    if (!function_exists('separateNumbersAndStrings')) {
        function separateNumbersAndStrings($input)
        {
            $userType = config('constants.object.user');
            preg_match_all('/\d+/', $input, $id);
            preg_match_all('/[a-zA-Z]+/', $input, $type);

            $id = implode('', $id[0]);
            $type = implode('', $type[0]);

            return [
                'id' => $id,
                'type' => !empty($type) ?  $type : $userType,
            ];
        }
    }
