<?php
return [
    'name' => [
        'not_allow_follower_view_chill_task' => 'Không cho phép người theo dõi xem được các công việc con',
        'allow_task_time_change_by_project_time' => 'Khi thời gian thực hiện dự án thay đổi thì thời gian công việc thay đổi theo',
        'not_allow_implementer_view_cross_task' => 'Không cho phép người thực hiện công việc xem chéo các công việc khác',
    ],
    'description' => [
        'not_allow_follower_view_chill_task' => 'Khi bật cài đặt này thì, ví dụ: Dự án A gồm 2 công việc B và C, người theo dõi dự án A sẽ không được xem công việc B và C nếu người đó không phải là người theo dõi công việc B và C',
        'allow_task_time_change_by_project_time' => 'Khi bật cài đặt này thì, ví dụ: Thời gian thực hiện dự án là 10/03/2020 - 20/03/2020, công việc X thuộc dự án A có thời gian thực hiện là 11/03/2020 - 15/03/2020. Khi dự án A được tịnh tiến 3 ngày, tức thời gian thực hiện là 13/03/2020 – 20/03/2020, thì thời gian công việc X cũng tịnh tiến thêm 3 ngày, tức là 14/03/2020 - 15/03/2020',
        'not_allow_implementer_view_cross_task' => 'Khi bật cài đặt này thì, ví dụ: Dự án A gồm 2 công việc B và C, người thực hiện công việc B sẽ không được xem công việc C nếu người đó không phải là người thực hiện công việc C',
    ]
];

