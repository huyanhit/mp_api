<?php
namespace App\Repositories\Project\ProjectPhase;

use App\Models\Project\ProjectPhase;
use App\Repositories\BaseRepository;

class ProjectPhaseRepository extends BaseRepository implements ProjectPhaseRepositoryInterface
{
    protected $model;

    public function __construct(ProjectPhase $model)
    {
        $this->model = $model;
    }

    public function getProjectPhases($request, $projectId)
    {
        $query = $this->model->query();
        $conditions= [
            ['column' => 'project_id', 'operator' => '=', 'value' => $projectId]
        ];

        if (!empty($request->search)) {
            $conditions[] = ['column' => 'name', 'operator' => 'LIKE', 'value' => "%$request->search%"];
        }

        $query = $this->filterConditions($query, $conditions);

        // Apply sorting
        $sortBy = $request->input('sort_by', 'created_at');
        $sortDirection = $request->input('sort_direction', 'asc');
        $query->orderBy($sortBy, $sortDirection);

        return $query->get();
    }
}
