<?php

namespace App\Repositories\Chat;

interface ChatRepositoryInterface
{
    public function getObject($object, $key);
    public function getObjectsByList($object, $list, $key = null);

    public function addObject($object, $prefix, $data);
    public function updateObject($object, $key, $data);
    public function deleteObject($object, $key);

    public function getList($object, $key, $property = null, $start = 0, $end = -1);
    public function getPageList($object, $key, $page, $reverse = false);
    public function getLenOfList($object, $key, $property = null);
    public function getListCondition($object, $key, $where);
}
