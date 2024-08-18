<?php

namespace App\Models\Project;

use App\Models\Task\Task;
use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProjectPhase extends Model
{
    use HasFactory, SoftDeletes, UserStamp;

    protected $table='work_project_phases';

    protected $fillable = [
        'project_id',
        'name',
        'slug',
        'start_date',
        'end_date',
        'calculate_progress_type',
        'progress',
        'description',
    ];

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }

    public function getTaskCountAttribute()
    {
        return $this->tasks()->count();
    }
}
