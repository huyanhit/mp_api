<?php

namespace App\Traits;

use App\Models\Chat\ModuleRoom;

trait ChatRoomModule
{
    # chatRoomModule được khai báo ở model có sử dụng tính năng Chat
    public function commentRoom()
    {
        return $this->hasOne(ModuleRoom::class, 'object_id')->where('module', $this->chatRoomModule);
    }
}
