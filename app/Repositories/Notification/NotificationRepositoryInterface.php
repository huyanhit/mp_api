<?php
namespace App\Repositories\Notification;

interface NotificationRepositoryInterface
{
    public function getUserSettingDefault($userId);
    public function getUserSettingCommand($userId, $command);
    public function saveNotification($auth, $params, $configs);
    public function saveUserNotification($notifyId, $userId, $read);
    public function updateNotification($notifyId, $params);
    public function updateSetting($id, $params);
    public function deleteNotification($notifyId);
    public function getNotifications();
    public function getSummary();
}
