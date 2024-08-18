<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class LogRequestParams
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $req, Closure $next): Response
    {
        try {
            $ip = $req->ip();
            $saveActivityLog   = config('constants.store_log_request');
            $host = $req->getHost();
            $subDomain = getSubDomain($host);
            config([
                'logging.channels.' . $subDomain. '_info' => [
                    'driver' => 'daily',
                    'path' => storage_path("logs/".$subDomain."/request_info/request_info.log"),
                    'level' => 'info',
                    'days' => 365
                ]
            ]);

            config([
                'logging.channels.' . $subDomain. '_error' => [
                    'driver' => 'daily',
                    'path' => storage_path("logs/".$subDomain."/request_error/request_error.log"),
                    'level' => 'error',
                    'days' => 365
                ]
            ]);

            $authId = 'no_login';
            if (Auth::guard('api')->check()) {
                $authId = "***". Auth::guard('api')->user()->id ."***";
            }
            $params = $req->except('password', 'repassword', '_token');
            if($saveActivityLog == true){
                $dataLog = array(
                    'ip'        => $ip , 
                    'auth_id'   => $authId, 
                    'method'    => $req->method(), 
                    'url'       => request()->path(), 
                    'params'    => json_encode($params, JSON_UNESCAPED_UNICODE)
                );
                Log::channel($subDomain. '_info')->info('Info', $dataLog);
            }
        } catch (\Exception $e) {
            $dataError =  array( 
                'ip'            => $ip, 
                'auth_id'       => $authId, 
                'method'        => $req->method(), 
                'url'           => request()->path(), 
                'params'        => json_encode($params, JSON_UNESCAPED_UNICODE), 
                'browser_info'  => $req->header('User-Agent') ,
                'error_msg'     => $e
            );
            Log::channel($subDomain. '_error')->error('Error', $dataError);
        }
        return $next($req);
    }
}
