<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use App\Repositories\Permission\PermissionRepositoryInterface;
use App\Helpers\Helper;

class PermissionService {
    
    protected $permissionRepository;

    public function __construct(PermissionRepositoryInterface $permissionRepository)
    {
        $this->permissionRepository = $permissionRepository;
    }

    public function getPermissionsList($request)
    {
       return $this->permissionRepository->getPermissionsList($request);
    }

    public function getPermissionsByGroup(bool $portal = false)
    {
        $groups = Helper::permissions();

        // example logic for get group portal
        if ($portal) {
            // data portal test
            $portalGroups = [
                [
                    'group_key' => 'user',
                    'modules' => [
                        [
                            'module_key' => 'employee',
                            'permissions' => [
                                ['name' => 'view_user'],
                                ['name' => 'create_user'],
                            ]
                        ],
                    ]
                ]
            ];

            $filteredGroups = collect($groups)->map(function ($group) use ($portalGroups) {
                $filteredGroup = collect($portalGroups)->first(function ($portalGroup) use ($group) {
                    return $group['group_key'] === $portalGroup['group_key'];
                });

                if ($filteredGroup) {
                    $group['modules'] = collect($group['modules'])->map(function ($module) use ($filteredGroup) {
                        $filteredModule = collect($filteredGroup['modules'])->first(function ($portalModule) use ($module) {
                            return $module['module_key'] === $portalModule['module_key'];
                        });

                        if ($filteredModule) {
                            $module['permissions'] = collect($module['permissions'])->filter(function ($permission) use ($filteredModule) {
                                return collect($filteredModule['permissions'])->contains('name', $permission['name']);
                            })->values()->all();
                            return $module;
                        } else {
                            return null;
                        }
                    })->filter()->values()->all();

                    return $group;
                } else {
                    return null;
                }
            })->filter()->values()->all();

            return $filteredGroups;
        }

        return $groups;
    }

    public function show($id)
    {
       return $this->permissionRepository->show($id);
    }

    public function updatePermission($request, $id)
    {
        try {
            DB::beginTransaction();

            $data = [
                'name_string' => $request->name_string,
                'description' => $request->description,
            ];

            $permission = $this->permissionRepository->update($data, $id);

            DB::commit();

            return $permission;
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;
        }
    }

    public function generatePermissionPortal($request)
    {
        // logic with portal

        return $this->getPermissionsByGroup(true);
    }
}
