<?php
namespace App\Repositories\Project;

interface ProjectRepositoryInterface
{
   public function list($request);

   public function summaryByStatus($request);

   public function getKanbanList($request);
}
