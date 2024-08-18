<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class RoomFile extends Model
{
    use HasFactory, UserStamp, SoftDeletes;
    protected $table = 'chat_room_file';

    protected $fillable = [
        'room_id', 'file_id'
    ];
}
