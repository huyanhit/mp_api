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
        Schema::create('chat_contacts', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id'); // auth id
            $table->integer('contact_id'); // contact user_id
            $table->integer('requested'); // 1: requested 2: approve
            $table->integer('room_id')->nullable(); // room_id for contact direct

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
        Schema::dropIfExists('chat_contacts');
    }
};
