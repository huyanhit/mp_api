<?php

return [
    App\Providers\AppServiceProvider::class,
    App\Providers\HelperServiceProvider::class,
    App\Providers\ModuleServiceProvider::class,
    App\Providers\AuthServiceProvider::class,
    App\Providers\PoliciesServiceProvider::class,
    # Repository
    App\Providers\RepositoryServiceProvider::class,
    App\Providers\WorkRepositoryServiceProvider::class,
    App\Providers\HRMRepositoryServiceProvider::class,
    App\Providers\CRMRepositoryServiceProvider::class,
];
