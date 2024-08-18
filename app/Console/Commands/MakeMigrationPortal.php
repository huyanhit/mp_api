<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use App\Helpers\Helper;

class MakeMigrationPortal extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'make:MigrationPortal';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Chạy các migrations cho tất cả database Portal';

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
                $migrations = $this->getMigrations();
                if(!empty($migrations)){
                    foreach ($migrations as $migration) {
                        Artisan::call('migrate', [
                            '--database' => $database,
                            '--path'     => $migration
                        ]);
                    }
                }
            }
        }
    }

    /* Lấy migrations trong tất cả module */
    protected function getMigrations(): array
    {
        $modules = Helper::allModules();
        $migrations = ['database/migrations'];
        if (!empty($modules)) {
            foreach ($modules as $module) {
                $migrations[] = 'App/Modules/'.$module.'/Database/Migrations';
            }
        }
        return $migrations;
    }
}
