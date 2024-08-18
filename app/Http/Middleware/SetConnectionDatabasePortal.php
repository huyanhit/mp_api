<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Exceptions\ProcessException;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\DB;
use App\Helpers\Helper;

class SetConnectionDatabasePortal
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        # Set connection database for portal
        try {
            $hostName = $request->getHost();
            $mainDomain   = env('MAIN_DOMAIN', null); 
            # Check portal available
            if($hostName != $mainDomain) {
                $validPortal = false; # Kiểm tra tính hợp lệ của portal
                $subDomain = str_replace("." . $mainDomain, "", $hostName);
                if($subDomain != null){
                    $_where = array(
                        'subdomain' => $subDomain,
                        'active'    => true
                    );
                    # Check exist portal on database
                    $portal = DB::connection('pgsql')->table('portals')->where($_where)->whereNull('deleted_at')->first();
                    if($portal) {
                        $database = $portal->database;
                        # Set connection database for portal
                        configConnection($database);
                        DB::setDefaultConnection($database);
                        $validPortal = true;
                    } 
                }

                # Store error log and show message
                if($validPortal == false){
                    $message = 'Hostname '.$hostName. " not found";
                    $errorLog = array(
                        'module'    => __METHOD__,
                        'action'    => __FUNCTION__,
                        'msg_log'   => $message
                    );
                    Helper::trackingError($errorLog);
                    return Helper::sendError(null, $message, 404);
                }
            }
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
        return $next($request);
    }
}
