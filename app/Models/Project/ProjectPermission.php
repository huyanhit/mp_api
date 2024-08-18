<?php

namespace App\Models\Project;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProjectPermission extends Model
{
    use HasFactory, SoftDeletes, UserStamp;

    protected $table='work_project_permissions';

    protected $fillable= [
        'project_id',
        'permission_key',
        'permission_description',
    ];
}
