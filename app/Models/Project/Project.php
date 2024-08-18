<?php

namespace App\Models\Project;

use App\Models\RelationObject\WorkRelationObject;
use App\Models\Task\Task;
use App\Traits\DynamicActivityLog;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Traits\DocumentAttachment;
use App\Traits\UserStamp;
use App\Traits\TagModule;
use App\Traits\ChatRoomModule;

class Project extends Model
{
    use DynamicActivityLog;
    use HasFactory, SoftDeletes, UserStamp, DocumentAttachment, TagModule, ChatRoomModule;

    protected $table='work_projects';
    protected $tagModule; # module sử dụng trong bảng tags_module
    protected $chatRoomModule; # module sử dụng trong bảng chat_module_room

    protected $fillable = [
        'project_group_id',
        'tag_id',
        'code',
        'title',
        'start_date',
        'end_date',
        'actual_start_date',
        'actual_end_date',
        'status',
        'budget',
        'calculate_progress_type',
        'calculate_progress_attributes',
        'progress',
        'description',
    ];

    protected $casts= [
        'start_date' => 'date:Y-m-d',
        'end_date' => 'date:Y-m-d',
        'actual_start_date' => 'datetime:Y-m-d H:i',
        'actual_end_date' => 'datetime:Y-m-d H:i',
    ];

    public function __construct()
    {
        parent::__construct();
        # Sử dụng trong trait TagModule
        $this->tagModule = config('constants.tags.modules.project');
        # Sử dụng trong trait ChatRoomModule
        $this->chatRoomModule = config('constants.chat.modules.project');
    }

    public function getChatRoomModuleAttribute()
    {
        return $this->chatRoomModule;
    }

    public function group()
    {
        return $this->belongsTo(ProjectGroup::class, 'project_group_id')->withTrashed();
    }

    public function permissions()
    {
        return $this->hasMany(ProjectPermission::class);
    }

    public function objects()
    {
        return $this->morphMany(WorkRelationObject::class, 'model');
    }

    public function members()
    {
        $objectConfig = config('constants.object');

        return $this->objects()->where('object_type', $objectConfig['user']);
    }

    public function managers()
    {
        $managerRole = config('constants.project.role.manager');

        return $this->objects()->where('role', $managerRole);
    }

    public function implementers()
    {
        $implementerRole = config('constants.project.role.implementer');

        return $this->objects()->where('role', $implementerRole);
    }

    public function followers()
    {
        $followerRole = config('constants.project.role.follower');

        return $this->objects()->where('role', $followerRole);
    }

    public function taskCategories()
    {
        return $this->hasMany(ProjectTaskCategory::class);
    }

    public function phases()
    {
        return $this->hasMany(ProjectPhase::class);
    }

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }

    public function children()
    {
        return $this->tasks()->whereNull('parent_id');
    }
}
