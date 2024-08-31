<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('notify_user_setting_notification', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id');   // user_id map table user

            $table->string('module')->nullable();  // module
            $table->string('feature')->nullable(); // chức năng
            $table->string('action')->nullable();  // hành động
            $table->string('command')->nullable(); // mỗi thông báo sẻ được config bằng 1 lệnh command
            $table->string('staffs')->default(''); // Luôn nhận thông báo từ array user_id
            $table->string('position')->default('bottom right'); // vị trí thông báo [ bottom left, bottom right, top left, top right]
            $table->string('sound')->default('default'); // Âm thanh [ default, ting-ting, buzz]
            $table->string('auto_close')->default('default'); //  tắt mở tự động đóng popup

            $table->boolean('is_notify')->default(true); // tắt mở các chế độ
            $table->boolean('is_mute')->default(false); // tắt tiếng
            $table->boolean('is_send')->default(false); // tắt mở send mail

            $table->boolean('open_popup')->default(false); // Hiển thị popup chi tiết đối tượng khi click vào thông báo
            $table->boolean('notify_mobile')->default(false); // Thông báo trên di động

            $table->timestamps();
            $table->softDeletes();
            $table->integer('created_by')->nullable();
            $table->integer('updated_by')->nullable();
            $table->integer('deleted_by')->nullable();
            $table->integer('sort')->default(99);
            $table->boolean('active')->default(true);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('notify_user_setting_notification');
    }
};
