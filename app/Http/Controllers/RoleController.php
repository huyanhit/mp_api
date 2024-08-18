<?php

namespace App\Http\Controllers;

use App\Exceptions\ProcessException;
use App\Helpers\Helper;
use App\Http\Requests\RoleRequest;
use App\Http\Resources\RoleResource;
use Illuminate\Http\Request;
use App\Services\RoleService;
use Spatie\Permission\Models\Role;

class RoleController extends BaseController
{
    protected $roleService;

    public function __construct(RoleService $roleService)
    {
        $this->roleService = $roleService;
        $this->authorizeResource(Role::class);
    }

    protected function resourceAbilityMap()
    {
        return array_merge(parent::resourceAbilityMap(), [
            'index' => 'view',
        ]);
    }

    public function index(Request $request)
    {
        try {
            $data = $this->roleService->getRolesList($request);
            $data = RoleResource::collection($data)->resource;

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function store(RoleRequest $request)
    {
        try {
            $data = $this->roleService->createRole($request);
            $data = new RoleResource($data);

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function show(Role $role)
    {
        try {
            $data = $this->roleService->show($role->id);
            $data = new RoleResource($data);

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function update(RoleRequest $request, $id)
    {
        try {
            $data = $this->roleService->updateRole($request, $id);
            $data = new RoleResource($data);

            return $this->sendResponse($data, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function destroy($id)
    {
        try {
            $this->roleService->deleteRole($id);

            return $this->sendResponse(null, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function bulkDelete(Request $request)
    {
        try {
            $ids = data_get($request, 'ids', []);
            $this->roleService->deleteRoles($ids);

            return $this->sendResponse(null, null);
        } catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

}
