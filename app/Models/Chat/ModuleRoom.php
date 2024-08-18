<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ModuleRoom extends Model
{
    use HasFactory, UserStamp, SoftDeletes;
    protected  $table = 'chat_module_room';

    protected $fillable = [
        'module', 'object_id', 'room_id'
    ];
}
