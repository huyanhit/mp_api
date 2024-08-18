************ Tích hợp module chat vào các module khác  ************

Trong các chức năng cần sử dụng tính năng chat (trao đổi) thì thực hiện các bước như sau:

* Bước 1 : Định nghĩa module mới sẽ sử dụng chức năng chat trong biến modules tại app\Modules\Chat\Config\constants.php mới được tạo room
* Bước 2 : Thêm lệnh use App\Traits\Chat; trong file chứa hàm cần sử dụng
* Bước 3 : Tại các hàm cần sử dụng tính năng chat gọi một trong các hàm sau để thực hiện chức năng tương ứng:

- $this->createDataModuleRoom($params) để tạo room chat cho đối tượng trong module
- $this->updateDataModuleRoom($params) để update room chat cho đối tượng trong module
- $this->getDataModuleRoom($params) để lấy thông tin room chat

Trong đó params sẽ bao gồm các thông tin sau:

$params['module'] : Tên module sử dụng tính năng chat, đã được định nghĩa ở Bước 1
$params['object_id'] : ID đối tượng trong module sử dụng tính năng chat (ID project, ID Document...)
$params['members'] = array('userId1' => $role1,'userId2' => $role2...) : danh sách user tham gia nhóm chat
- userId1, userId2 : ID của user tham gia nhóm chat
- role1, role2 : vai trò tương ứng của từng user trong nhóm chat để mặc định là 1

*  Bước 4 : Để hiển thị khung chat trên giao diện thì gọi component sau:
<comment object_id="1" module="project"></comment>
Trong đó :
- module: Tên module đã đã được định nghĩa ở Bước 1
- object_id: ID đối tượng sử dụng tính năng chat (ID project, ID Document...)

*** LƯU Ý ***
- Chỉ những chức năng defined trong biến modules tại app\Modules\Chat\Config\constants.php mới được tạo room.
- Khóa để unique xác định giá trị tồn tại hay chưa là (object_id && module) nếu tồn tại sẽ không tạo nữa, nên các room (document hay project) đã tạo trước đó sẽ không tạo thêm mà trả về giá trị trước đó khi call API.