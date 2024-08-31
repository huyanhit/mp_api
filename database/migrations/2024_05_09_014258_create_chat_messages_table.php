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
        Schema::create('chat_messages', function (Blueprint $table) {
            $table->integer('ids')->autoIncrement(); // ids tăng dần theo autoIncrement
            $table->integer('id')->default(0); // id tăng dần theo room và thread
            $table->text('content')->nullable(); // nội dung tin nhắn
            $table->integer('room_id')->default(0); // room id
            $table->integer('status')->default(1); // trạng thái tin nhắn [1. normal, 2:had edit]
            $table->integer('auth')->default(0); // user_id đã nhắn tin
            $table->integer('thread')->default(0); // ids tin nhắn reply

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
        Schema::dropIfExists('chat_messages');
    }
};
