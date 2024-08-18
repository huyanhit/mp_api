<?php

namespace Database\Seeders;

use App\Helpers\Helper;
use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RoleDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $groups = Helper::permissions();
        Helper::generatePermissions($groups);

        Role::firstOrCreate(['name' => 'Quản trị viên', 'description' => 'Tài khoản nhân viên quản lí', 'guard_name' => 'api'])->syncPermissions(Permission::all());
        Role::firstOrCreate(['name' => 'Nhân viên', 'description' => 'Tài khoản nhân viên bình thường', 'guard_name' => 'api']);
        $super_admin = Role::firstOrCreate(['name' => 'Super-Admin', 'description' => 'Tài khoản không cần check quyền', 'guard_name' => 'api']);

        $user = User::firstOrCreate(
            ['email' => 'superadmin@example.com'],
            [
                'name' => 'Super Admin',

                'password' => 'Admin@123',
                'phone' => '0000000000'
            ]);

        $user->assignRole($super_admin);
    }
}
