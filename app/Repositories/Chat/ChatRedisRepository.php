<?php

namespace App\Repositories\Chat;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redis;

class ChatRedisRepository implements ChatRepositoryInterface {
    const SEPARATE_KEY = '_';
    private array $config;
    public function __construct(){
        $this->config = config('redis');
    }

    public function getObject($object, $key): ?array
    {
        if(isset($this->config[$object])){
            $prefix = array_key_first($this->config[$object]);
            $properties  = $this->config[$object][$prefix];
            if($prefix === '[KEY]' && isset($properties['type'])){
                return [$object => [$key => Redis::lrange($object. self::SEPARATE_KEY .$key, 0 , -1)]];
            }else{
                return $this->getProperties($object, $key, $properties);
            }
        }

        return null;
    }

    public function getObjectsByList($object, $list, $prefix = null): array
    {
        if($list) {
            $response = [];
            $objects = array_map(function ($id) use ($object, $prefix) {
                $key = empty($prefix) ? $id : $prefix . '_' . $id;
                return $this->getObject($object, $key)[$object];
            }, $list);
            foreach ($objects as $value) {
                $response = array_replace($response, $value);
            }

            return [$object => $response];
        }

        return [];
    }

    private function addListObjects($object, $data)
    {
        $lists = $this->getKeyList($object);
        if($lists){
            foreach ($lists as $obj => $val){
                $key   = array_key_first($val);
                $value = $val[$key];
                if($value === 'AUTO_CR'){
                    return $this->autoIncrementList($this->renderKey($obj, $data[$key]?? 1, null));
                } else {
                    return $this->pushList($obj, $data[$key], null, $data[$value]);
                }
            }
        }

    }

    private function pushListObject($object, $data): void
    {
        $lists =  $this->getListPush($object);
        if($lists) {
            foreach ($lists as $obj => $val) {
                $key = array_key_first($val);
                $value = $val[$key];
                $this->pushList($obj, $data[$key], null, $data[$value]);
            }
        }
    }

    public function addObject($object, $prefix, $data = null): ?string
    {
        $id = $this->addListObjects($object, $data);
        $this->pushListObject($object, $data);
        $key = empty($prefix) ? $id : $prefix . '_' . $id;
        $maps = $this->mapKeyRedis($object, $key, $data, true);
        if(is_array($maps)){
            foreach ($maps as $k => $v){
                if(!empty($v)) Redis::set($k, $v);
            }
            return $key;
        }

        return null;
    }

    public function updateObject($object, $key, $data): ?string
    {
        $maps = $this->mapKeyRedis($object, $key, $data);
        if(is_array($maps)){
            foreach ($maps as $k => $v){
                Redis::set($k, $v);
            }
            return $key;
        }

        return null;
    }

    public function deleteObject($object, $key): ?string
    {
        $maps = $this->mapKeyRedis($object, $key, null, true);
        if(is_array($maps)){
            foreach ($maps as $k => $v){
                Redis::del($k);
            }
            return $key;
        }

        return null;
    }

    public function getList($object, $key, $property = null, $start = 0, $end = -1): array
    {
        return Redis::lrange($this->renderKey($object, $key, $property), $start, $end);
    }

    public function getLenOfList($object, $key, $property = null): int
    {
        $k = $this->renderKey($object, $key, $property);
        if(Redis::exists($k)){
            return Redis::llen($k);
        }

        return 0;
    }

    private function getKeyList($object){
        return isset($this->config[$object]['[LIST]'])?$this->config[$object]['[LIST]']:null;
    }

    private function getListPush($object){
        return isset($this->config[$object]['[PUSH]'])? $this->config[$object]['[PUSH]']: [];
    }



    private function pushList($object, $key, $property = null, $value = null)
    {
        $k = $this->renderKey($object, $key, $property);
        if(empty($value)){
            return $this->autoIncrementMaxList($k);
        }else{
            return $this->setListValue($k, $value);
        }
    }



    private function removeList($object, $key, $property = null, $value = null): int
    {
        $k = $this->renderKey($object, $key, $property);
        return Redis::lrem($k, 0, $value);
    }

    private function getProperties($object, $key, $properties): array
    {
        $response = [];
        foreach ($properties as $index => $property){
            $k = $object. self::SEPARATE_KEY .$index. self::SEPARATE_KEY .$key;
            if(isset($property['type']) && ($property['type'] == 'list')){
                $value = Redis::lrange($k, 0 , -1);
            }else{
                $value = Redis::get($k);
                $value = empty($value)? $property['default']: $value;
            }
            if(isset($property['type']) ){
                switch ($property['type']){
                    case 'integer':
                        $value = (int)$value;
                        break;
                }
            }

            $response = array_merge($response, [$property['name'] => $value]);
        }

        return [$object => [$key => $response]];
    }

    private function mapKeyRedis($object, $key, $data = null, $all = false): array|string|null
    {
        if(isset($this->config[$object])){
            $prefix = array_key_first($this->config[$object]);
            $properties  = $this->config[$object][$prefix];
            if($prefix === '[KEY]' && isset($properties['type'])){
                return $object. self::SEPARATE_KEY .$key;
            }else{
                return $this->mapProperties($properties, $data, $object, $key, $all);
            }
        }

        return null;
    }

    private function mapProperties($properties, $data, $object, $key, $all): array
    {
        $keys = [];
        foreach ($properties as $index => $property){
            if(isset($property['name'])){
                if(isset($data[$property['name']])){
                    $keys[$object. self::SEPARATE_KEY .$index. self::SEPARATE_KEY .$key] = $data[$property['name']];
                }elseif($all){
                    if(isset($property['type']) && $property['type'] == 'list'){
                        $keys[$object. self::SEPARATE_KEY .$index. self::SEPARATE_KEY .$key] = [];
                    }else{
                        $keys[$object. self::SEPARATE_KEY .$index. self::SEPARATE_KEY .$key] = $property['default'];
                    }
                }
            }
        }

        return $keys;
    }

    private function renderKey($object, $key, $property): string
    {
        if(empty($property)){
            return $object. self::SEPARATE_KEY .$key;
        }

        return $object. self::SEPARATE_KEY .$property. self::SEPARATE_KEY .$key;
    }

    private function autoIncrementList($key): int
    {
        $increment = 0;
        if(Redis::exists($key)){
            $increment = Redis::llen($key);
        }
        Redis::rpush($key, ++$increment);

        return $increment;
    }

    private function autoIncrementMaxList($key): int{
        $increment = 1;
        if(Redis::exists('INCR_'.$key)){
            Redis::incr('INCR_'.$key);
            $increment = Redis::get('INCR_'.$key);
        }else{
            Redis::set('INCR_'.$key, '1');
        }
        Redis::rpush($key, $increment);

        return $increment;
    }

    private function setListValue($key, $value)
    {
        if(Redis::exists($key)) {
            $list = Redis::lrange($key, 0, -1);
            if(!in_array($value, $list)){
                Redis::rpush($key, $value);
            }
        }else{
            Redis::rpush($key, $value);
        }

        return $value;
    }

    public function getListCondition($object, $key, $where)
    {
        // TODO: Implement getListCondition() method.
    }

    public function getPageList($object, $key, $page, $reverse = false)
    {
        // TODO: Implement getPageList() method.
    }
}
