<?php

namespace App\Providers;

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Gate;
use App\Pagination\CustomPaginator;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Contracts\Pagination\LengthAwarePaginator as LengthAwarePaginatorContract;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->alias(CustomPaginator::class, LengthAwarePaginator::class); // Eloquent uses the class instead of the contract 🤔
        $this->app->alias(CustomPaginator::class, LengthAwarePaginatorContract::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        JsonResource::withoutWrapping();

        # ChiNV cấu hình multi domain - start
        config([
            'app.domain' => parse_url(env('MAIN_DOMAIN'), PHP_URL_HOST),
            'session.domain' => parse_url(env('MAIN_DOMAIN'), PHP_URL_HOST),
        ]);
        # ChiNV cấu hình multi domain - end

        #todo remove this after optimize code
        DB::listen(function ($query) {
            File::append(storage_path('/logs/query.log'),
                '[' . date('Y-m-d H:i:s') . ' time: ' . $query->time . ']' . PHP_EOL . $query->sql . ' [' . implode(', ', $query->bindings) . ']' . PHP_EOL . PHP_EOL
            );
        });
    }
}
