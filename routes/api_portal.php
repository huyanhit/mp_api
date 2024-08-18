<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\UserController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PermissionController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/v1/login', [AuthController::class, 'login'])->name('auth.login');

Route::group([ 'middleware' => ['auth:api'], 'prefix' => '/v1'], function () {

    # Setting User
    Route::group(['prefix' => 'users', 'as' => 'users.'], function () {
        Route::put('set-language', [UserController::class, 'updateLanguage'])->name('updateLanguage');
        Route::put('set-dark-mode', [UserController::class, 'updateDarkMode'])->name('updateDarkMode');
        Route::put('change-password', [UserController::class, 'changePassword'])->name('changePassword');
    });
    # Module User
    Route::apiResource('users', UserController::class);

    // Module Role
    Route::delete('roles/bulk/delete', [RoleController::class, 'bulkDelete'])->name('roles.bulkDelete');
    Route::apiResource('roles', RoleController::class);

    // Module Permission
    Route::group(['prefix' => '/permissions'], function () {
        Route::apiResource('/', PermissionController::class);
        Route::get('list-by-group', [PermissionController::class, 'getPermissionsByGroup'])->name('permissions.permissionByGroup');
        Route::post('generate', [PermissionController::class, 'generatePermissionPortal'])->name('permissions.generate');
    });

    // Logout
    Route::post('/logout', [AuthController::class, 'logout'])->name('auth.logout');

    // Auth info
    Route::get('/get-auth', [AuthController::class, 'getAuth'])->name('auth.info');
});
