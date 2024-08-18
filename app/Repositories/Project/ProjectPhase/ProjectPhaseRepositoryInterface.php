<?php
namespace App\Repositories\Project\ProjectPhase;

interface ProjectPhaseRepositoryInterface
{
   public function getProjectPhases($request, $projectId);
}
