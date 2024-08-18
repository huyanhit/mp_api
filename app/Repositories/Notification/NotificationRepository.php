<?php
namespace App\Repositories\Notification;

use App\Models\Notification\Notification;
use App\Models\Notification\NotificationType;
use App\Models\Notification\UserNotification;
use App\Models\Notification\UserSettingNotification;
use App\Modules\Notification\Filters\NotificationFilter;
use Illuminate\Support\Facades\Auth;
use function PHPUnit\Framework\throwException;

class NotificationRepository implements NotificationRepositoryInterface
{
    public function getSummary()
    {
        $ids = UserNotification::where('user_id', Auth::id())->filter(new NotificationFilter(request()))->get()->pluck('notify_id');
        $readIds = UserNotification::where(['read'=> 0, 'user_id' => Auth::id()])->filter(new NotificationFilter(request()))->get()->pluck('notify_id');
        $all = collect([[
            'id'            => 0,
            'name'          => 'All',
            'total'         => Notification::whereIn('id', $ids)->count(),
            'total_unread'  => Notification::whereIn('id', $readIds)->count(),
        ]]);
        return $all->merge(NotificationType::get()->map(function ($type) use ($ids, $readIds){
            return collect([
                'id'            => $type->id,
                'name'          => $type->name,
                'total'         => Notification::whereIn('id', $ids)->where('type_id', $type->id)->count(),
                'total_unread'  => Notification::whereIn('id', $readIds)->where('type_id', $type->id)->count(),
            ]);
        }));
    }

    public function getNotifications()
    {
        $id = request('type_id')?? 0;
        $ids = UserNotification::where('user_id', Auth::id())
            ->filter(new NotificationFilter(request()))
            ->get()
            ->pluck('notify_id');

        if($id > 0){
            return Notification::whereIn('id', $ids)
                ->where('type_id', $id)->orderBy('id', 'DESC')
                ->paginate(config('constants.per_page'));
        }else{
            return Notification::whereIn('id', $ids)
                ->orderBy('id', 'DESC')
                ->paginate(config('constants.per_page'));
        }
    }

    public function saveNotification($auth, $params, $configs)
    {
        return Notification::create([
            'auth_id' => $auth,
            'content' => $configs['content'],
            'type_id' => $configs['type'],
            'title'   => $configs['title'],
            'url'     => $configs['url'],
            'action'  => $configs['action']?? null,
            'extra'   => json_encode($params),
        ]);
    }

    public function saveUserNotification($notifyId, $userId, $read = 0){
        return UserNotification::create(['notify_id'=> $notifyId, 'user_id' => $userId, 'read' => $read]);
    }

    public function updateNotification($notifyId, $params)
    {
        return UserNotification::where(['notify_id'=> $notifyId, 'user_id' => Auth::id()])->update($params);
    }

    public function updateSetting($id, $params)
    {
        $setting = UserSettingNotification::find($id);
        if(!empty($setting) && $setting->user_id === Auth::id()){
            foreach ($params as $key => $val){
                if(is_array($val)) $val = json_encode($val);
                if(isset($val)) $setting->$key = $val;
            }
            return $setting->save();
        }else{
            throwException(new \Exception('User not permission'));
        }
    }

    public function deleteNotification($notifyId)
    {
        return UserNotification::where(['notify_id'=> $notifyId, 'user_id' => Auth::id()])->delete();
    }

    public function getUserSettingDefault($userId): array
    {
        $setting = UserSettingNotification::where(['user_id' => $userId, 'command' => null])->first();
        if(empty($setting)){
            return $this->createDefaultUserSetting($userId)->toArray();
        }else{
            return $setting->toArray();
        }
    }

    public function getUserSettingCommand($userId, $command): array
    {
        $setting = UserSettingNotification::where(['user_id' => $userId, 'command' => $command])->first();
        if(empty($setting)){
            return $this->createRouterUserSetting($userId, $command);
        }else{
            return $setting->toArray();
        }
    }

    private function createDefaultUserSetting($userId)
    {
        $settings = config('constants.notification.user_setting');
        if(isset($settings) && isset($settings['default'])) {
            $default = $settings['default'];
            return UserSettingNotification::create([
                'user_id'    => $userId,
                'is_notify'  => $default['is_notify'],
                'is_mute'    => $default['is_mute'],
                'is_send'    => $default['is_send'],
                'auto_close' => $default['auto_close'],
                'position'   => $default['position'],
                'sound'      => $default['sound'],
            ]);
        }

        return collect();
    }

    private function createRouterUserSetting($userId, $command)
    {
        $settings = config('constants.notification.user_setting');
        if(isset($settings) && isset($settings['actions']) && isset($settings['default'])) {
            $default = $settings['default'];
            foreach ($settings['actions'] as $setting) {
                if($setting['command'] === $command){
                    return UserSettingNotification::create([
                        'user_id'   => $userId,
                        'module'    => $setting['module'],
                        'feature'   => $setting['feature'],
                        'action'    => $setting['action'],
                        'command'   => $setting['command'],
                        'is_notify' => $setting['is_notify'],
                        'is_mute'   => $setting['is_mute'],
                        'is_send'   => $setting['is_send'],
                        'auto_close'=> $default['auto_close'],
                        'position'  => $default['position'],
                        'sound'     => $default['sound'],
                    ])->toArray();
                }
            }
        }

        return [];
    }
}
