<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Exceptions\ProcessException;
use App\Http\Requests\ChangePasswordRequest;
use App\Http\Requests\DarkModeRequest;
use App\Http\Requests\LanguageRequest;
use App\Http\Requests\UserRequest;
use App\Http\Requests\UserSettingRequest;
use App\Http\Resources\UserResource;
use App\Services\UserService;
use App\Models\User;

class UserController extends BaseController
{
    protected $userService;

    function __construct(UserService $userService)
    {
        $this->userService = $userService;
        $this->authorizeResource(User::class);
    }

    public function index(Request $request)
    {
        try {
            $data = $this->userService->list($request);
            $data = UserResource::collection($data)->resource;
            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function store(UserRequest $request)
    {
        try {
            $user = $this->userService->create($request);
            $data = new UserResource($user);
            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }


    public function show($id)
    {
        try {
            $user = $this->userService->find($id);
            $data = new UserResource($user);
            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function update(UserRequest $request, $id)
    {
        try {
            $data = $this->userService->update($request, $id);
            $data = new UserResource($data);
            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function destroy($id)
    {
        try {
            $this->userService->delete($id);
            return $this->sendResponse(null, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function updateLanguage(LanguageRequest $request){
        try {
            $userId = Auth::user()->id;
            $data = $this->userService->updateFields($userId, ['language'], $request);
            $data = new UserResource($data);
            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function updateDarkMode(DarkModeRequest $request){
        try {
            $userId = Auth::user()->id;
            $data = $this->userService->updateFields($userId, ['dark_mode'], $request);
            $data = new UserResource($data);
            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function changePassword(ChangePasswordRequest $request)
    {
        try {
            $data = $this->userService->changePassword($request);
            $data = new UserResource($data);
            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }
}
