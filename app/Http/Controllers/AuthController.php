<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Exceptions\ProcessException;
use App\Http\Requests\AuthRequest;
use App\Services\AuthService;
use Illuminate\Support\Facades\Auth;

class AuthController extends BaseController
{
    protected $authService;

    function __construct(AuthService $authService)
    {
        $this->authService = $authService;
    }

    /**
     * Handle an authentication attempt.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(AuthRequest $request): JsonResponse
    {
        try {
            $data = $this->authService->login($request);
            return $this->sendResponse($data, 'Đăng nhập thành công');
        }
        catch(\Exception $e) {
            throw new ProcessException($e);
        }
    }

    /**
     * Log the user out of the application.
     *
     * @param  \Illuminate\Http\Request  $request
     */
    public function logout(Request $request) : JsonResponse
    {
        try {
            $request->user()->currentAccessToken()->delete();
            return $this->sendResponse(null, __('Remove Token Success'));
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function getAuth() : JsonResponse
    {
        try {
            return $this->sendResponse(Auth::user(), __('Token good'));
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }
}
