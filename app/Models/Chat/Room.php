<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Room extends Model
{
    use HasFactory, UserStamp, SoftDeletes;

    protected  $table = 'chat_rooms';

    protected $fillable = [
        'name', 'description', 'icon', 'type', 'status', 'pin', 'total'
    ];
}
