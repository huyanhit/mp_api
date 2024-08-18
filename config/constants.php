
<?php
    return array(
        # Trạng thái lưu log request của người dùng: true: lưu, false : không lưu
        'store_log_request' => true,
        'per_page' => 15,
        'limit' => 15,
        'page' => 1,
        'setting_columns' => [
            'language', 
            'dark_mode'
        ],
        # Prefix data cho database
        'prefix_database_portal'  => 'project_management_portal', // project_management_portal+ID : project_management_portal_1,
        # Đối tượng
        'object' => [
            'user' => 'U', // Nhân viên
            'department' => 'D', // Phòng ban
        ],
    );
?>

