<?php
namespace App\Repositories\Project\ProjectGroup;

use App\Models\Project\ProjectGroup;
use App\Repositories\BaseRepository;

class ProjectGroupRepository extends BaseRepository implements ProjectGroupRepositoryInterface
{
    protected $model;

    public function __construct(ProjectGroup $model)
    {
        $this->model = $model;
    }

    public function list($request)
    {
        $query = $this->query();

        // Apply search
        $keyword = $request->keyword;
        if (!empty($keyword)) {
            $query = $query->where('name', 'LIKE', "%$keyword%");
        }

        // Apply sorting
        $sort = data_get($request, 'sort', 'id');
        $sortBy = data_get($request, 'order_by', 'asc');
        $this->orderBy($query, [$sort => $sortBy]);

        return $this->pagination($query);
    }
}
