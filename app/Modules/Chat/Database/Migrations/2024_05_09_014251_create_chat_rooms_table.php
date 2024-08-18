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
        Schema::create('chat_rooms', function (Blueprint $table) {
            $table->id();
            $table->string('name'); // Tên room
            $table->string('description')->nullable(); // Mô tả room
            $table->string('icon')->nullable(); // image icon
            $table->integer('type')->default(1); // loại room [1. public room, 2. private room, 3 room direct],
            $table->integer('pin')->default(0); // room được pin [1.pin, 0.unpin]
            $table->integer('total')->default(0); // Tổng số message trong room

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
        Schema::dropIfExists('chat_rooms');
    }
};
