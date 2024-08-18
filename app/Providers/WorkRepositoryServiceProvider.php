<?php
namespace App\Providers;

use Illuminate\Support\ServiceProvider;

# Project
use App\Repositories\Project\ProjectRepository;
use App\Repositories\Project\ProjectRepositoryInterface;
# Project Group
use App\Repositories\Project\ProjectGroup\ProjectGroupRepository;
use App\Repositories\Project\ProjectGroup\ProjectGroupRepositoryInterface;
# Project Phase
use App\Repositories\Project\ProjectPhase\ProjectPhaseRepository;
use App\Repositories\Project\ProjectPhase\ProjectPhaseRepositoryInterface;
# Document
use App\Repositories\Document\DocumentRepository;
use App\Repositories\Document\DocumentRepositoryInterface;
use App\Repositories\Document\DocumentAttach\DocumentAttachRepository;
use App\Repositories\Document\DocumentAttach\DocumentAttachRepositoryInterface;
use App\Repositories\Document\DocumentModuleAttach\DocumentModuleAttachRepository;
use App\Repositories\Document\DocumentModuleAttach\DocumentModuleAttachRepositoryInterface;
# Chat
use App\Repositories\Chat\ChatRepository;
use App\Repositories\Chat\ChatRepositoryInterface;
# Tag
use App\Repositories\Tag\TagRepository;
use App\Repositories\Tag\TagRepositoryInterface;
# Task
use App\Repositories\Task\TaskRepository;
use App\Repositories\Task\TaskRepositoryInterface;
# Task Type
use App\Repositories\Task\TaskType\TaskTypeRepository;
use App\Repositories\Task\TaskType\TaskTypeRepositoryInterface;
# Task Unit
use App\Repositories\Task\TaskUnit\TaskUnitRepository;
use App\Repositories\Task\TaskUnit\TaskUnitRepositoryInterface;

# Workflow Groups
use App\Repositories\Workflow\WorkflowGroup\WorkflowGroupRepository;
use App\Repositories\Workflow\WorkflowGroup\WorkflowGroupRepositoryInterface;

# Asset
use App\Repositories\Asset\AssetRepository;
use App\Repositories\Asset\AssetRepositoryInterface;
use App\Repositories\Asset\AssetType\AssetTypeRepository;
use App\Repositories\Asset\AssetType\AssetTypeRepositoryInterface;
use App\Repositories\Asset\AssetPosition\AssetPositionRepository;
use App\Repositories\Asset\AssetPosition\AssetPositionRepositoryInterface;
# Asset Supplier
use App\Repositories\Asset\AssetSupplier\AssetSupplierRepository;
use App\Repositories\Asset\AssetSupplier\AssetSupplierRepositoryInterface;

#Settings
use App\Repositories\Setting\SettingRepository;
use App\Repositories\Setting\SettingRepositoryInterface;

class WorkRepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        # Project
        $this->app->bind(ProjectRepositoryInterface::class, ProjectRepository::class);
        # Project Group
        $this->app->bind(ProjectGroupRepositoryInterface::class, ProjectGroupRepository::class);
        # Project phase
        $this->app->bind(ProjectPhaseRepositoryInterface::class, ProjectPhaseRepository::class);
        # Document
        $this->app->bind(DocumentRepositoryInterface::class, DocumentRepository::class);
        # Document Attach
        $this->app->bind(DocumentAttachRepositoryInterface::class, DocumentAttachRepository::class);
        # Document Module Attach
        $this->app->bind(DocumentModuleAttachRepositoryInterface::class, DocumentModuleAttachRepository::class);
        # Chat
        $this->app->bind(ChatRepositoryInterface::class, ChatRepository::class);
        # Tag
        $this->app->bind(TagRepositoryInterface::class, TagRepository::class);
        # Task Type
        $this->app->bind(TaskTypeRepositoryInterface::class, TaskTypeRepository::class);
        # Task Unit
        $this->app->bind(TaskUnitRepositoryInterface::class, TaskUnitRepository::class);
        # Task
        $this->app->bind(TaskRepositoryInterface::class, TaskRepository::class);
        # Workflow Groups
        $this->app->bind(WorkflowGroupRepositoryInterface::class, WorkflowGroupRepository::class);
        # Asset
        $this->app->bind(AssetRepositoryInterface::class, AssetRepository::class);
        # Asset Type
        $this->app->bind(AssetTypeRepositoryInterface::class, AssetTypeRepository::class);
        # Asset Position
        $this->app->bind(AssetPositionRepositoryInterface::class, AssetPositionRepository::class);
        # Asset Supplier
        $this->app->bind(AssetSupplierRepositoryInterface::class, AssetSupplierRepository::class);
        # Settings
        $this->app->bind(SettingRepositoryInterface::class, SettingRepository::class);
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
