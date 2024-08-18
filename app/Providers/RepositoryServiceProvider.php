<?php
namespace App\Providers;

use Illuminate\Support\ServiceProvider;

# Sample
use App\Repositories\Sample\SampleRepository;
use App\Repositories\Sample\SampleRepositoryInterface;
# Base
use App\Repositories\BaseRepository;
use App\Repositories\RepositoryInterface;
# Portal
use App\Repositories\Portal\PortalRepository;
use App\Repositories\Portal\PortalRepositoryInterface;
# User
use App\Repositories\User\UserRepository;
use App\Repositories\User\UserRepositoryInterface;
# Permission
use App\Repositories\Permission\PermissionRepository;
use App\Repositories\Permission\PermissionRepositoryInterface;
# Role
use App\Repositories\Role\RoleRepository;
use App\Repositories\Role\RoleRepositoryInterface;
# Department
use App\Repositories\Department\DepartmentRepository;
use App\Repositories\Department\DepartmentRepositoryInterface;
# Department Business
use App\Repositories\Department\DepartmentBusiness\DepartmentBusinessRepository;
use App\Repositories\Department\DepartmentBusiness\DepartmentBusinessRepositoryInterface;
# Department Type
use App\Repositories\Department\DepartmentType\DepartmentTypeRepository;
use App\Repositories\Department\DepartmentType\DepartmentTypeRepositoryInterface;
# Notification
use App\Repositories\Notification\NotificationRepository;
use App\Repositories\Notification\NotificationRepositoryInterface;
# Activity
use App\Repositories\Activity\ActivityRepository;
use App\Repositories\Activity\ActivityRepositoryInterface;
# Tag Module
use App\Repositories\Tag\TagModule\TagModuleRepository;
use App\Repositories\Tag\TagModule\TagModuleRepositoryInterface;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        # Sample
        $this->app->bind(SampleRepositoryInterface::class, SampleRepository::class);
        # Base
        $this->app->bind(RepositoryInterface::class, BaseRepository::class);
        # Portal
        $this->app->bind(PortalRepositoryInterface::class, PortalRepository::class);
        # User
        $this->app->bind(UserRepositoryInterface::class, UserRepository::class);
        # Permission
        $this->app->bind(PermissionRepositoryInterface::class, PermissionRepository::class);
        # Role
        $this->app->bind(RoleRepositoryInterface::class, RoleRepository::class);
        # Department
        $this->app->bind(DepartmentRepositoryInterface::class, DepartmentRepository::class);
        # Department Business
        $this->app->bind(DepartmentBusinessRepositoryInterface::class, DepartmentBusinessRepository::class);
        # Department Type
        $this->app->bind(DepartmentTypeRepositoryInterface::class, DepartmentTypeRepository::class);
        # Notification
        $this->app->bind(NotificationRepositoryInterface::class, NotificationRepository::class);
        # Activity
        $this->app->bind(ActivityRepositoryInterface::class, ActivityRepository::class);
        # Tag Module
        $this->app->bind(TagModuleRepositoryInterface::class, TagModuleRepository::class);
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
