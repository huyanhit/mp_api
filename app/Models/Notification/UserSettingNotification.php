<?php

namespace App\Models\Notification;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Traits\DocumentAttachment;
use App\Traits\UserStamp;

class UserSettingNotification extends Model
{
    use HasFactory, UserStamp, SoftDeletes;

    protected $table='notify_user_setting_notification';

    protected $fillable = [
        'user_id',
        'module',
        'feature',
        'action',
        'router',
        'command',
        'position',
        'auto_close',
        'sound',
        'is_notify',
        'is_mute',
        'is_send',
    ];
}
