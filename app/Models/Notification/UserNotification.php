<?php

namespace App\Models\Notification;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Traits\UserStamp;
use App\Traits\Filterable;

class UserNotification extends Model
{
    use HasFactory, UserStamp, SoftDeletes, Filterable;

    protected $table='notify_user_notification';

    protected $fillable = [
        'id', 'user_id', 'notify_id', 'read'
    ];
}
