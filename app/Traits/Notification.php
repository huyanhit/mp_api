<?php

namespace App\Traits;

use App\Modules\Notification\Services\NotificationService;
use App\Repositories\Notification\NotificationRepositoryInterface;

trait Notification
{
    public function pushNotification($command, $params = []): void
    {
        $notification = new NotificationService(app(NotificationRepositoryInterface::class));
        $notification->pushNotification($command, $params);
    }
}