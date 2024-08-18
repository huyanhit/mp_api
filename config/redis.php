<?php
return [
    'MY_USER' => [
        '[KEY]' => ['type' => 'list']
    ],
    'CONTACT' => [
        '[KEY]' => [
            'USER_ID'     => ['name' => 'user_id',     'type' => 'integer',   'default' => 0],
            'CONTACT_ID'  => ['name' => 'Contact_id',  'type' => 'integer',  'default' => 0],
            'CREATED'     => ['name' => 'created_at',  'type' => 'timestamp', 'default' => now()->timestamp],
            'UPDATED'     => ['name' => 'updated_at',  'type' => 'timestamp', 'default' => now()->timestamp],
        ],
        '[LIST]' => ['MY_USER' => ['user_id' => 'contact_id']],
    ],
    'MY_ROOM' => [
        '[KEY]' => ['type' => 'list']
    ],
    'ROOMS' => [
        '[KEY]' => ['type' => 'list']
    ],
    'ROOM' => [
        '[KEY]' => [
            'NAME'        => ['name' => 'name',        'type' => 'string',    'default' => ''],
            'DESCRIPTION' => ['name' => 'description', 'type' => 'string',    'default' => ''],
            'ICON'        => ['name' => 'icon',        'type' => 'string',    'default' => ''],
            'TYPE'        => ['name' => 'type',        'type' => 'integer',   'default' => 0],
            'STATUS'      => ['name' => 'status',      'type' => 'integer',   'default' => 0],
            'PINED'       => ['name' => 'pin',         'type' => 'integer',   'default' => 0],
            'TOTAL'       => ['name' => 'total',       'type' => 'integer',   'default' => 0],
            'CREATED'     => ['name' => 'created_at',  'type' => 'timestamp', 'default' => now()->timestamp],
            'UPDATED'     => ['name' => 'updated_at',  'type' => 'timestamp', 'default' => now()->timestamp],
        ],
        '[LIST]' => ['ROOMS' => ['company_id' => 'AUTO_CR']]
    ],
    'ROOM_MESSAGE' => [
        '[KEY]' => ['type' => 'list']
    ],
    'MESSAGE' => [
        '[KEY]' => [
            'CONTENT'   => ['name' => 'content',   'type' => 'string',    'default' => ''],
            'STATUS'    => ['name' => 'status',    'type' => 'integer',   'default' => 0],
            'AUTH'      => ['name' => 'auth',      'type' => 'integer',   'default' => 0],
            'THREAD'    => ['name' => 'thread',    'type' => 'integer',   'default' => 0],
            'CREATED'   => ['name' => 'created_at',  'type' => 'timestamp', 'default' => now()->timestamp],
            'UPDATED'   => ['name' => 'updated_at',  'type' => 'timestamp', 'default' => now()->timestamp],
        ],
        '[LIST]' => ['ROOM_MESSAGE' => ['room_id' => 'AUTO_CR']]
    ],
    'ROOM_MEMBER' => [
        '[KEY]' => ['type' => 'list']
    ],
    'MEMBER' => [
        '[KEY]' => [
            'TYPE'      => ['name' => 'type',     'type' => 'integer',   'default' => 0],
            'POSITION'  => ['name' => 'position', 'type' => 'integer',   'default' => 0],
            'MENTION'   => ['name' => 'mention',  'type' => 'integer',   'default' => 0],
            'CREATED'   => ['name' => 'created_at',  'type' => 'timestamp', 'default' => now()->timestamp],
            'UPDATED'   => ['name' => 'updated_at',  'type' => 'timestamp', 'default' => now()->timestamp],
        ],
        '[PUSH]' =>  [
            'MY_ROOM' => ['user_id' => 'room_id'],
            'ROOM_MEMBER' => ['room_id' => 'user_id'],
        ]
    ],
    'FILES' => [
        '[KEY]' => ['type' => 'list']
    ],
    'MY_FILE' => [
        '[KEY]' => ['type' => 'list']
    ],
    'ROOM_FILE' => [
        '[KEY]' => ['type' => 'list']
    ],
    'MESSAGE_FILE' => [
        '[KEY]' => ['type' => 'list']
    ],
    'FILE' => [
        '[KEY]' => [
            'NAME'       => ['name' => 'name',      'type' => 'string',   'default' => ''],
            'EXT'        => ['name' => 'ext',       'type' => 'string',   'default' => ''],
            'TYPE'       => ['name' => 'type',      'type' => 'string',   'default' => ''],
            'PATH'       => ['name' => 'path',      'type' => 'string',   'default' => ''],
            'STORE'      => ['name' => 'store',     'type' => 'string',   'default' => '0'],
            'CREATED'   => ['name' => 'created_at',  'type' => 'timestamp', 'default' => now()->timestamp],
            'UPDATED'   => ['name' => 'updated_at',  'type' => 'timestamp', 'default' => now()->timestamp],
        ],
        '[LIST]' => ['FILES' => ['company_id' => 'AUTO_CR']]
    ],
];
