<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
use Symfony\Component\HttpKernel\Exception\BadRequestHttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException;
use App\Helpers\Helper;

# Middleware set connection database for portal
use App\Http\Middleware\SetConnectionDatabasePortal;

# Middleware check token hết hạn
use App\Http\Middleware\CheckTokenExpiration;

# Middleware chặn account đang bị khóa
use App\Http\Middleware\DenyInactiveAccount;

# Middleware params request vào file log
use App\Http\Middleware\LogRequestParams;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        api: __DIR__ . '/../routes/api.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        # Set connection database for portal
        //$middleware->append(SetConnectionDatabasePortal::class);

        # Check token hết hạn
        $middleware->append(CheckTokenExpiration::class);

        # Chặn account đang bị khóa
        $middleware->append(DenyInactiveAccount::class);

        # Lưu params request vào file log
        $middleware->append(LogRequestParams::class);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        $exceptions->render(function (Throwable $e) {
            $statusCode = null;
            $message = null;

            switch (true) {
                case $e instanceof BadRequestHttpException:
                    $message = __('common.response_code.400');
                    $statusCode = Response::HTTP_BAD_REQUEST;
                    break;

                case $e instanceof AccessDeniedHttpException:
                    $message = __('common.response_code.403');
                    $statusCode = Response::HTTP_FORBIDDEN;
                    break;

                case $e instanceof NotFoundHttpException:
                    $message = __('common.response_code.404');
                    $statusCode = Response::HTTP_NOT_FOUND;
                    break;

                case $e instanceof MethodNotAllowedHttpException:
                    $message = __('common.response_code.405');
                    $statusCode = Response::HTTP_METHOD_NOT_ALLOWED;
                    break;

                default:
                    break;
            }

            if (!empty($statusCode)) {
                # Log error
                $errorLog = array(
                    'module'    => request()->getMethod(),
                    'action'    => request()->getRequestUri(),
                    'msg_log'   => getMessage($e)
                );
                Helper::trackingError($errorLog);

                # Response
                $response = [
                    'success' => false,
                    'message' => $message,
                    'data'   => []
                ];
                return response()->json($response, $statusCode);
            }
        });
    })->create();
