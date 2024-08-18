
************* Hướng dẫn sử dụng UserStamp.php ************* 
Link file : app\Traits\UserStamp.php

Trong các model cần cập nhật tự động các trường created_(at, by), updated_(at, by), deleted_(at, by) hoặc tự động lấy thông tin user tạo (createdBy), user update(updatedBy), user xóa (deletedBy) thì sử dụng như sau:

1. Thêm lệnh use App\Traits\UserStamp; trước khai báo class model
2. Trong class khai báo khai báo model thêm lệnh use UserStamp; 

VD: Áp dụng đối với model Project.php (app\Models\Project\Project.php)

<?php
namespace App\Models\Project;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

use App\Traits\UserStamp;

class Project extends Model
{
    use HasFactory, SoftDeletes, UserStamp;

    protected $table='work_projects';
}

