<?php

namespace App\Models\Chat;

use App\Traits\UserStamp;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Contact extends Model
{
    use HasFactory, UserStamp, SoftDeletes;
    protected  $table = 'chat_contacts';

    protected $fillable = [
        'user_id', 'contact_id', 'room_id', 'requested'
    ];
}
