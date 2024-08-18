<?php
namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Gate;

# Document
use App\Modules\Document\Policies\DocumentPolicy;
use App\Models\Document\Document;

class PoliciesServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        // Register policy
        Gate::policy(Document::class, DocumentPolicy::class);
    }
}
