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
        Schema::create('notify_notifications', function (Blueprint $table) {
            $table->id();

            $table->string('title')->nullable(); // title thông báo
            $table->text('content'); // nội dung thông báo chính.
            $table->text('extra');   // các thông báo nội dung mở rộng.
            $table->string('action')->nullable(); // hành động hiển thị trên thông báo.
            $table->string('url')->nullable(); // link khi click vào thông báo
            $table->integer('auth_id'); // id người gửi map table USER
            $table->integer('type_id')->default(0); // loai thông báo map table notify_notification_types

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
        Schema::dropIfExists('notify_notifications');
    }
};
