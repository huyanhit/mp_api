<?php

namespace App\Traits;

use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Models\Activity;

trait DynamicActivityLog {

    use LogsActivity;

    protected bool $tapped = false;

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logFillable()
            ->logOnlyDirty();
    }

    public function tapActivity(Activity $activity, string $eventName)
    {
        if ($this->tapped) {
            $this->tapped = false;
            return;
        }

        $this->tapped = true;

        $modelName = strtolower(class_basename($this));

        $activity->log_name = $modelName;
        $activity->description = $modelName . '_' . $eventName.'_description';
        $activity->event = $modelName . '_' . $eventName;
    }
}
