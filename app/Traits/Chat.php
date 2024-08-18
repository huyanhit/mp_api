<?php

namespace App\Traits;

use App\Exceptions\ProcessException;
use App\Modules\Chat\Services\MemberService;
use App\Modules\Chat\Services\RoomService;
use App\Repositories\Chat\ChatRepositoryInterface;

Trait Chat
{
    /*
        Hàm lấy thông tin room với tham số như  sau:
        $params['module'] : Tên module sử dụng tính năng chat
        $params['object_id'] : Đối tượng trong module sử dụng tính năng chat
    */
    public function getDataModuleRoom($params)
    {
        $chatRepository = app(ChatRepositoryInterface::class);
        $roomService = new RoomService($chatRepository);
        $key = $params['module'].'_'.$params['object_id'];
        $object = $roomService->getChatRepository()->getObject('MODULE_ROOM', $key);
        if(!empty($object['MODULE_ROOM'][$key])){
            return $object['MODULE_ROOM'][$key];
        }else{
            throw new ProcessException('Module Room not found');
        }
    }

    /*
        Hàm tạo room chat với tham số như  sau:
        $params['module'] : Tên module sử dụng tính năng chat
        $params['object_id'] : ID đối tượng trong module sử dụng tính năng chat
        $params['members'] = array('userId1' => $role1,'userId2' => $role2...) : danh sách user tham gia nhóm chat
        - userId1, userId2 : ID của user tham gia nhóm chat
        - role1, role2 : vai trò tương ứng của từng user trong nhóm chat để mặc định là 1
    */
    public function createDataModuleRoom($params)
    {
        $chatRepository = app(ChatRepositoryInterface::class);
        $roomService = new RoomService($chatRepository);
        $memberService = new MemberService($chatRepository);
        $key = $params['module'].'_'.$params['object_id'];
        $object = $roomService->getChatRepository()->getObject('MODULE_ROOM', $key);
        if(empty($object['MODULE_ROOM'][$key])){
            $params['name'] = $key;
            $key = $roomService->addRoom($params, 2);
            $moduleRoom = ['module' => $params['module'], 'room_id' => $key, 'object_id' => $params['object_id']];
            $roomService->addModuleRoom($moduleRoom, $params['module']);
            $memberService->addMembersIntoRoom($key, $params['members']);

            return $moduleRoom;
        }else{
            return $object['MODULE_ROOM'][$key];
        }
    }

    /*
        Hàm update room chat với tham số như  sau:
        $params['module'] : Tên module sử dụng tính năng chat
        $params['object_id'] : ID đối tượng trong module sử dụng tính năng chat
        $params['members'] = array('userId1' => $role1,'userId2' => $role2...) : danh sách user tham gia nhóm chat
        - userId1, userId2 : ID của user tham gia nhóm chat
        - role1, role2 : vai trò tương ứng của từng user trong nhóm chat để mặc định là 1
    */
    public function updateDataModuleRoom($params)
    {
        $chatRepository = app(ChatRepositoryInterface::class);
        $roomService = new RoomService($chatRepository);
        $memberService = new MemberService($chatRepository);
        $key = $params['module'].'_'.$params['object_id'];
        $object = $roomService->getChatRepository()->getObject('MODULE_ROOM', $key);
        if(!empty($object['MODULE_ROOM'][$key])){
            $memberService->updateMembers($object['MODULE_ROOM'][$key]['room_id'], $params['members']);
            $object = $roomService->getChatRepository()->getObject('MODULE_ROOM', $key);

            return $object['MODULE_ROOM'][$key];
        }else{
            throw new ProcessException('Module Room not found');
        }
    }

    public function createOrUpdateProjectCommentRoom($model)
    {
        $module = $model->chatRoomModule;
        $room = $model->commentRoom;

        $params = [
            'object_id' => $model->id,
            'module' => $module,
        ];

        $params['members'] = $model->members->pluck('id')->mapWithKeys(function ($id) {
            return [$id => 1];
        })->toArray();

        if (empty($room)) {
            // Call function from strait Chat
            $this->createDataModuleRoom($params);
        } else {
            // Call function from strait Chat
            $this->updateDataModuleRoom($params);
        }
    }
}
