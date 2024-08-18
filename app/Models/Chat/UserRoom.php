<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserRoom extends Model
{
    use HasFactory, UserStamp, SoftDeletes;
    protected  $table = 'chat_user_room';

    protected $fillable = [
        'user_id', 'room_id', 'type', 'position'
    ];
}
