<?php

namespace Tests\Unit\Services;

use PHPUnit\Framework\TestCase;
use App\Modules\Asset\Services\AssetService;
use App\Repositories\Asset\AssetRepositoryInterface;
use Mockery as m;

class AssetTest extends TestCase
{
    protected $repository;
    protected $service;

    public function setUp(): void
    {
        parent::setUp();
        $this->repository = m::mock(AssetRepositoryInterface::class);
        $this->service = new AssetService($this->repository);
    }

    public function tearDown(): void
    {
        m::close();
        parent::tearDown();
    }

    public function testList()
    {
        $request = new \stdClass(); // Simulate request object
        $this->repository->shouldReceive('list')->with($request)->once()->andReturn('expected result');
        $result = $this->service->list($request);
        $this->assertEquals('expected result', $result);
    }

    public function testSave()
    {
        $request = new \stdClass(); // Simulate request object
        $request->name = 'Asset Type Name';
        $request->code = 'Asset Type Code';
        $request->unit = 1;
        $request->purchase_date = now();
        $request->department_id = 1;
        $request->status = 'new';
        $request->sort = 1;
        $request->active = true;
        // Add other properties as needed
        $this->repository->shouldReceive('create')->once()->andReturn(true);
        $result = $this->service->save($request);
        $this->assertTrue($result);
    }

    public function testFind()
    {
        $id = 1;
        $this->repository->shouldReceive('find')->with($id)->once()->andReturn('expected result');
        $result = $this->service->find($id);
        $this->assertEquals('expected result', $result);
    }

    public function testUpdate()
    {
        $id = 1;
        $request = new \stdClass(); // Simulate request object
        $request->name = 'Updated Asset Type Name';
        $request->code = rand(1, 100);
        $request->unit = 1;
        $request->purchase_date = now();
        $request->department_id = 1;
        $request->status = 'new';
        $request->sort = 1;
        $request->active = true;
        // Add other properties as needed
        $this->repository->shouldReceive('update')->with(m::type('array'), $id)->once()->andReturn(true);
        $result = $this->service->update($request, $id);
        $this->assertTrue($result);
    }

    public function testDelete()
    {
        $id = 1;
        $this->repository->shouldReceive('delete')->with($id)->once()->andReturn(true);
        $this->service->delete($id);
        $this->assertTrue(true); // If no exceptions, test is passed
    }
}