<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use App\Helpers\Helper;

class MakeSeederPortal extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'make:MakeSeederPortal';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Chạy các seeder cho tất cả database Portal';

    /**
     * Execute the console command.
     */

    public function handle()
    {
        $databasePortals = DB::connection('pgsql')->table('portals')->pluck('database')->toArray();
        $databasePortals[] = 'project_management_portal_template';
        if(count($databasePortals) > 0 ){
            foreach ($databasePortals as $database) {
                configConnection($database);
                Artisan::call('db:seed', [
                    '--database' => $database
                ]);
            }
        }
    }
}
