<?php

use App\Modules\Chat\Controllers\CommentController;
use App\Modules\Chat\Controllers\FileController;
use App\Modules\Chat\Controllers\MemberController;
use App\Modules\Chat\Controllers\MessageController;
use App\Modules\Chat\Controllers\ReactionController;
use App\Modules\Chat\Controllers\RoomController;
use App\Modules\Chat\Controllers\ContactController;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->group(function () {
    Route::group(['prefix' => '/chat'], function (){
        Route::get('/get-file-thumbnail/{id}', [FileController::class, 'getFileThumbnail']);
        Route::get('/get-file-raw/{id}', [FileController::class, 'getFileRaw']);
        Route::get('/get-user/{type}', [ContactController::class, 'getUser']);
        Route::get('/get-my-rooms', [RoomController::class, 'getMyRooms']);
        Route::get('/get-module-room', [RoomController::class, 'getModuleRoom']);
        Route::get('/comment-room/{id}', [CommentController::class, 'getRoom']);
        Route::get('/contact-guests', [ContactController::class, 'getAllGuest']);

        Route::post('/create-module-room', [RoomController::class, 'createModuleRoom']);
        Route::post('/update-module-room', [RoomController::class, 'updateModuleRoom']);
        Route::post('/set-unread', [MemberController::class, 'setUnread']);
        Route::post('/join-room', [RoomController::class, 'joinRoom']);
        Route::post('/thread', [CommentController::class, 'thread']);

        Route::post('/contact/approve', [ContactController::class, 'approve']);
        Route::post('/contact/request', [ContactController::class, 'request']);
        Route::post('/contact/un-request', [ContactController::class, 'unRequest']);
        Route::post('/contact/cancel', [ContactController::class, 'cancel']);
        Route::post('/contact/remove', [ContactController::class, 'remove']);

        Route::resource('/room', RoomController::class);
        Route::resource('/comment', CommentController::class);
        Route::resource('/message', MessageController::class);
        Route::resource('/contact', ContactController::class);
        Route::resource('/file', FileController::class);
        Route::resource('/reaction', ReactionController::class);
    });
});