<?php

namespace App\Models\Notification;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Traits\UserStamp;
use Illuminate\Support\Facades\Auth;

class NotificationType extends Model
{
    use HasFactory, UserStamp, SoftDeletes;

    protected $table='notify_notification_types';

    protected $fillable = [
        'name'
    ];

    public function total(): Attribute
    {
        return Attribute::make(get: fn () => $this->notification->count());
    }

    public function totalUnread(): Attribute
    {
        return Attribute::make(get: fn () => $this->AuthUnreadNotification->count());
    }

    public function notification(): HasManyThrough
    {
        return $this->hasManyThrough(
            UserNotification::class,
            Notification::class,
            'type_id','notify_id','id')
            ->where(['notify_user_notification.user_id' => Auth::id()]);
    }

    public function AuthUnreadNotification(): HasManyThrough
    {
        return $this->hasManyThrough(
            UserNotification::class,
            Notification::class,
            'type_id','notify_id','id')
            ->where(['read' => 0, 'notify_user_notification.user_id' => Auth::id()]);
    }
}
