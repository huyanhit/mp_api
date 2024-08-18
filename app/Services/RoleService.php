<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use App\Repositories\Role\RoleRepositoryInterface;

class RoleService {
    protected $roleRepository;

    public function __construct(RoleRepositoryInterface $roleRepository)
    {
        $this->roleRepository = $roleRepository;
    }

    public function getRolesList($request)
    {
       return $this->roleRepository->getRolesList($request);
    }

    public function createRole($request)
    {
        try {
            DB::beginTransaction();

            $data = [
                'name' => $request->name,
                'description' => $request->description,
            ];

            $permissions = data_get($request, 'permission_ids', []);

            $role = $this->roleRepository->create($data);
            $role->syncPermissions($permissions);
            DB::commit();

            return $role;
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;
        }
    }

    public function show($id)
    {
       return $this->roleRepository->show($id);
    }

    public function updateRole($request, $id)
    {
        try {
            DB::beginTransaction();

            $data = [
                'name' => $request->name,
                'description' => $request->description,
            ];

            $permissions = data_get($request, 'permission_ids', []);

            $role = $this->roleRepository->update($data, $id);
            $role->syncPermissions($permissions);

            DB::commit();

            return $role;
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }

    public function deleteRole($id)
    {
        try {
            DB::beginTransaction();

            $this->roleRepository->delete($id);

            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;
        }
    }

    public function deleteRoles(array $ids)
    {
        try {
            DB::beginTransaction();

            $this->roleRepository->bulkDelete($ids);

            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;
        }
    }

}
