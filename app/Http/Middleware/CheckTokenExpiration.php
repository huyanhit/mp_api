<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use App\Helpers\Helper;

class CheckTokenExpiration
{
    # Các route sẽ bỏ qua không check
    protected $exceptUrl  = array(
        '/',
        'api/v1/login',
        'api/v1/document/documents/viewer',
        'api/v1/document/attachments/viewer',
    );
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        try {
            $pathUrl = parse_url($request->path());
            $pathUrl = $pathUrl['path'];
            if (!in_array($pathUrl, $this->exceptUrl) && !Auth::guard('api')->check()) {
                return Helper::sendError(null,__('common.token_error.expire'), 401);
            }
        } catch (\Exception $e) {
            $errorLog = array(
                'module'    => $request->getMethod(),
                'action'    => $request->getRequestUri(),
                'msg_log'   => getMessage($e)
            );
            Helper::trackingError($errorLog);
            return Helper::sendError(null, __('common.response_code.500') , 500);
        }
        return $next($request);
    }
}
