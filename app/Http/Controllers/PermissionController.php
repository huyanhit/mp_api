<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Exceptions\ProcessException;
use App\Http\Requests\PermissionRequest;
use App\Http\Resources\PermissionResource;
use App\Services\PermissionService;

class PermissionController extends BaseController
{
    protected $permissionService;

    public function __construct(PermissionService $permissionService)
    {
        $this->permissionService = $permissionService;
    }

    public function index(Request $request)
    {
        try {
            $data = $this->permissionService->getPermissionsList($request);
            $data = PermissionResource::collection($data)->resource;

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function getPermissionsByGroup()
    {
        try {
            $data = $this->permissionService->getPermissionsByGroup();

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function show($id)
    {
        try {
            $data = $this->permissionService->show($id);
            $data = new PermissionResource($data);

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function update(PermissionRequest $request, $id)
    {
        try {
            $data = $this->permissionService->updatePermission($request, $id);
            $data = new PermissionResource($data);

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function generatePermissionPortal(Request $request)
    {
        try {
            $data = $this->permissionService->generatePermissionPortal($request);

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }
}
