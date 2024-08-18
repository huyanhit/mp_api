<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use App\Helpers\Helper;

class DenyInactiveAccount
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        try {
            $authUser = Auth::guard('api')->user() ?? null;
            if ($authUser != null && $authUser->active == false) {
                return Helper::sendError(null, __('common.account_error.inactive'), 403);
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
