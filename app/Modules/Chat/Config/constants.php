<?php
    # Khai báo module sử dụng tính năng chat
    $modules = array(
        'project'  => "project", # Module App\Models\Project\Project.php
        'document' => "document", # Module App\Models\Document\Document.php
        'task' => "task", # Module App\Models\Task\Task.php
    );

    # Init config
    $configs =  [
        'store_file' => 'local',
        'thumbnail_separate' => 'thumb_',
        'list_item_file' => 15,
        'image_type' => ['jpg','jpeg','png','gif','webp','apng','avif','pjpeg','jfif','pjp','svg'],
        'video_type' => ['mp4','avi','wmv','ogg','ogv','webm','flv','swf','ram','rm','mov','mpeg','mpg'],
    ];

    # Append config
    $configs['modules'] = $modules;

    # Trả về configs với tiền tố chat
    return array('chat' => $configs);