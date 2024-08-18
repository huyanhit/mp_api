<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use App\Helpers\Helper;

class MakeMigrationAll extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'make:MigrationAll';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Chạy các migrations trong tất cả module';

    /**
     * Execute the console command.
     */

    public function handle()
    {
        $migrations = $this->getMigrations();
        if(!empty($migrations)){
            foreach ($migrations as $migration) {
                Artisan::call('migrate', [
                    '--path' => $migration
                ]);
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
                $migrations[] = 'app/Modules/'.$module.'/Database/Migrations';
            }
        }
        return $migrations;
    }
}
