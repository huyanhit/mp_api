<?php

namespace App\Repositories\Project;

use App\Models\Project\Project;
use App\Modules\Project\Resources\ProjectResource;
use App\Repositories\BaseRepository;
use Carbon\Carbon;

class ProjectRepository extends BaseRepository implements ProjectRepositoryInterface
{
    protected $model;

    public function __construct(Project $project)
    {
        $this->model = $project;
    }

    public function list($request)
    {
        $query = $this->handleFilter($request);
        $query->with([
            'tags',
            'members',
            'managers',
            'implementers',
            'followers',
            'group',
            'permissions',
            'objects',
            'taskCategories',
            'tasks',
            'children',
            'documentAttachs',
            'commentRoom',
            'createdBy',
        ]);

        // Apply sorting
        $sort = data_get($request, 'sort', 'id');
        $sortBy = data_get($request, 'order_by', 'desc');
        $this->orderBy($query, [$sort => $sortBy]);

        return $this->pagination($query);
    }

    public function summaryByStatus($request)
    {
        $request->tab = null;
        $statuses = array_values(config('constants.project.status'));

        $statusCountRaw = $this->getStatusCountsRaw($statuses);
        $summaries = $this->handleFilter($request)
            ->selectRaw($statusCountRaw)
            ->first();

        return collect($summaries)->map(function ($value, $key) {
            return [
                'id' => $key,
                'count' => $value
            ];
        })->values();
    }

    public function getKanbanList($request)
    {
        $request->tab = null;
        $statuses = array_values(config('constants.project.status'));
        $data = [];

        foreach ($statuses as $status) {
            $items = $this->handleFilter($request)->with([
                'tags',
                'members',
                'managers',
                'implementers',
                'followers',
                'group',
                'permissions',
                'objects',
                'taskCategories',
                'tasks',
                'children',
                'documentAttachs',
                'commentRoom',
                'createdBy',
            ])->where('status', $status)->limit(5)->latest()->get();

            $data[$status] = ProjectResource::collection($items);
        }
//        $data = $this->handleFilter($request)->with([
//            'tags',
//            'members',
//            'managers',
//            'implementers',
//            'followers',
//            'group',
//            'permissions',
//            'objects',
//            'taskCategories',
//            'tasks',
//            'children',
//            'documentAttachs',
//            'commentRoom',
//            'createdBy',
//        ])->groupBy();
//        $data = ProjectResource::collection($data);

        return $data;
    }

    public function handleFilter($request)
    {
        $query = $this->query();

        # Apply search
        $keyword = $request->keyword;
        if (!empty($keyword)) {
            $query = $query->where(function ($query) use ($keyword) {
                return $query->where('title', 'LIKE', "%$keyword%")
                    ->orWhere('description', 'LIKE', "%$keyword%")
                    ->orWhere('code', 'LIKE', "%$keyword%");
            });
        }

        if (!empty($request->tab) && $request->tab !== 'all') {
            $query = $query->where('status', '=', $request->tab);
        }

        if (!empty($request->menu)) {
            $authId = auth()->id();
            $userType = config('constants.object.user');
            $roles = config('constants.project.role');
            if ($request->menu === $roles['manager'])
                $query = $query->whereHas('managers', function ($query) use ($authId, $userType) {
                    return $query->where('object_id', $authId)->where('object_type', $userType);
                });

            if ($request->menu === $roles['implementer'])
                $query = $query->whereHas('implementers', function ($query) use ($authId, $userType) {
                    return $query->where('object_id', $authId)->where('object_type', $userType);
                });
            if ($request->menu === $roles['follower'])
                $query = $query->whereHas('followers', function ($query) use ($authId, $userType) {
                    return $query->where('object_id', $authId)->where('object_type', $userType);
                });
        }

        # Apply filters with simple whereIn clauses
        $this->filterWhereIn($query, 'status', $request->status);
        $this->filterWhereIn($query, 'project_group_id', $request->project_group_ids);
        $this->filterWhereIn($query, 'created_by', $request->created_by_ids);

        # Apply relational filters
        $this->filterWhereHasIn($query, 'tags', 'tag_id', $request->tag_ids);

        # todo: filter objects
        $this->filterWhereHasIn($query, 'members', 'object_id', $request->member_ids);
        $this->filterWhereHasIn($query, 'managers', 'object_id', $request->manager_ids);
        $this->filterWhereHasIn($query, 'implementers', 'object_id', $request->implementer_ids);
        $this->filterWhereHasIn($query, 'followers', 'object_id', $request->follower_ids);

        # Apply date range filters
        $this->filterDateRange($query, 'created_at', $request->created_at_from, $request->created_at_to);
        $this->filterDateRange($query, 'start_date', $request->start_date_from, $request->start_date_to);
        $this->filterDateRange($query, 'end_date', $request->end_date_from, $request->end_date_to);

        return $query;
    }
}
