<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = \Faker\Factory::create();
        $users = [
            [
                'username' => 'superadmin',
                'password' => Hash::make('Admin@123'),
                'language' => 'vi',
                'avatar' => $faker->imageUrl('50','50'),
                'remember_token' => Str::random(10),
                'active' => 1,
            ],
            [
                'username' => 'huyanhit',
                'password' => Hash::make('123456'),
                'language' => 'vi',
                'avatar' => $faker->imageUrl('50','50'),
                'remember_token' => Str::random(10),
                'active' => 1,
            ],
        ];
        // for($i = 0; $i < 50; $i++) {
        foreach($users as $user){
            DB::table('users')->insert($user);
        }
        // }
    }
}
