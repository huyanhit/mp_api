<?php

namespace App\Models\Project;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProjectGroup extends Model
{
    use HasFactory, SoftDeletes, UserStamp;

    protected $table='work_project_groups';

    protected $fillable = [
        'name',
        'status',
        'material_manage',
        'financial_manage',
    ];
}
