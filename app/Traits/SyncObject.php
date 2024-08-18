<?php

namespace App\Traits;

trait SyncObject
{
    public function syncObjects($model, $request)
    {
        $managerIds = data_get($request, 'manager_ids', []);
        $implementerIds = data_get($request, 'implementer_ids', []);
        $followerIds = data_get($request, 'follower_ids', []);
        $roles = config('constants.project.role');

        $managers = $this->transformMembers($managerIds, $roles['manager']);
        $implementers = $this->transformMembers($implementerIds, $roles['implementer']);
        $followers = $this->transformMembers($followerIds, $roles['follower']);
        $members = $managers->merge($implementers)->merge($followers);

        $currentObjectsIds = $model->objects->pluck('id');
        $newObjects = [];

        foreach ($members as $member) {
            $newObjects[] = $model->objects()->updateOrCreate($member);
        }

        $newObjectIds = collect($newObjects)->pluck('id');

        $deleteObjectsIds = $currentObjectsIds->diff($newObjectIds)->all();

        $model->objects()->whereIn('id', $deleteObjectsIds)->delete();

        return $model;
    }

    private function transformMembers(array $ids, $role)
    {
        return collect($ids)->map(function ($id) use ($role) {
            $object = separateNumbersAndStrings($id);
            return [
                'object_id' => $object['id'],
                'object_type' => $object['type'],
                'role' => $role,
            ];
        });
    }
}
