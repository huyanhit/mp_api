<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class File extends Model
{
    use HasFactory, UserStamp, SoftDeletes;
    protected  $table = 'chat_files';

    protected $fillable = [
        'name', 'ext', 'type', 'path', 'store'
    ];
}
