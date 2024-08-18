<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Message extends Model
{
    use HasFactory, UserStamp, SoftDeletes;

    public $timestamps = false;
    protected $table = 'chat_messages';
    protected $primaryKey = 'ids';
    protected $fillable = [
        'id', 'content', 'room_id', 'status', 'auth', 'thread'
    ];
}
