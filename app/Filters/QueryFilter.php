<?php

namespace App\Filters;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class QueryFilter
{
    public $request;

    protected $filters;

    protected $search = [];

    protected $builder;

    protected $orderField = null;

    protected $orderType = 'desc';

    protected $filterable;

    public function __construct(Request $request)
    {
        $this->request = $request;
        $this->filters = $this->request->all();
    }

    public function apply(Builder $builder)
    {
        $this->builder = $builder;

        foreach ($this->filters as $name => $value)
        {
            $method = 'filter' . Str::studly($name);

            if (is_null($value) || $value == '') {
                continue;
            }

            if (method_exists($this, $method)) {
                $this->{$method}($value);
                continue;
            }

            if (empty($this->filterable) || !is_array($this->filterable)) {
                continue;
            }

            if (in_array($name, $this->filterable)) {
                $this->builder->where($name, $value);
                continue;
            }

            if (key_exists($name, $this->filterable)) {
                $this->builder->where($this->filterable[$name], $value);
            }
        }

        return $this->builder;
    }
}
