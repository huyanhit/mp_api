<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MessageFile extends Model
{
    use HasFactory, UserStamp, SoftDeletes;
    protected $table = 'chat_message_file';

    protected $fillable = [
        'message_id', 'file_id'
    ];
}
