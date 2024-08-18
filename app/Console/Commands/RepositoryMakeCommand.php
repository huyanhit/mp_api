<?php

namespace App\Console\Commands;

use Illuminate\Console\GeneratorCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Exception\InvalidArgumentException;

class RepositoryMakeCommand extends GeneratorCommand
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'make:repository {name} {--model=} {--path=}';
    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Create a new model repository';

    /**
     * The type of class being generated.
     *
     * @var string
     */
    protected $type = 'Repository';

    /**
     * The name of class being generated.
     *
     * @var string
     */
    private $model;

    /**
     * Execute the console command.
     *
     * @return bool|null
     */
    public function handle() 
    {
        if(!$this->validateOptionValues()) {
            return;
        }
        $name = $this->qualifyClass($this->getNameInput());

        $path = $this->getPath($name);

        if ($this->alreadyExists($this->getNameInput())) {
            $this->error($this->type.' already exists!');

            return false;
        }

        $this->call('make:repository-interface', [
            'name' => $this->getNameInput().'Interface',
            '--path' => $this->option('path'),
        ]);

        $this->makeDirectory($path);

        $this->files->put($path, $this->buildClass($name));

        $this->info($this->type.' created successfully.');

        $this->line("<info>Created Repository :</info> $name");
    }

    /**
     * Set repository class name
     *
     * @return  void
     */

    /**
     * Replace the class name for the given stub.
     *
     * @param  string  $stub
     * @param  string  $name
     * @return string
     */
    protected function replaceClass($stub, $name)
    {
        if(!$this->argument('name')){
            throw new InvalidArgumentException("Missing required argument repository name");
        }

        $stub = parent::replaceClass($stub, $name);
        $modelName = $this->option('model');

        return str_replace('DummyModel', $modelName, $stub);
    }


    /**
     * 
     * Get the stub file for the generator.
     *
     * @return string
     */
    protected function getStub()
    {
        return  base_path('stubs/Repository.stub');
    }
    /**
     * Get the default namespace for the class.
     *
     * @param  string  $rootNamespace
     * @return string
     */
    protected function getDefaultNamespace($rootNamespace)
    {
        return $rootNamespace . '\Repositories' . ($this->option('path') ? '\\' . $this->option('path') : '');
    }

    /**
     * Get the console command arguments.
     *
     * @return array
     */
    protected function getArguments()
    {
        return [
            ['name', InputArgument::REQUIRED, 'The name of the repository class.'],
        ];
    }

    /**
     * Optional value
     *
     * @return array
     */
    private function optionValues()
    {
        return [
            'model'
        ];
    }

    /**
     * Validate optional
     *
     * @return array
     */
    private function validateOptionValues()
    {
        foreach ($this->optionValues() as $value) {
            if(!$this->option($value)) {
                $this->line("<error>Please enter require input :</error> $value");
                return false;
            }
            return true;
        }
    }
}