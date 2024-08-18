<?php

namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Exceptions\CustomException;
use App\Repositories\User\UserRepositoryInterface;
use Illuminate\Support\Facades\DB;
class UserService
{
    protected $userRepository;


    public function __construct(UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }


    /**
     * Paginate the users based on the given parameters.
     *
     * @param array $params The parameters for pagination.
     * @param array $columns The columns to retrieve from the users table. Default is all columns.
     * @param array $orderBy The order by criteria for the pagination. Default is empty.
     * @return Illuminate\Pagination\LengthAwarePaginator The paginated users.
     */
    public function list($request)
    {
        return $this->userRepository->list($request);
    }

    /**
     * Find a user by their ID.
     *
     * @param int $id The ID of the user to find.
     * @return User|null The user object if found, null otherwise.
     */
    public function find($id)
    {
        return $this->userRepository->find($id);
    }

    /**
     * Create a new user.
     *
     * @param array $data The data for creating the user.
     * @return User The created user.
     */
    public function create($request)
    {
        $data = $this->getData($request, 'create');
        return $this->userRepository->create($data);
    }

    /**
     * Update a user.
     *
     * @param int $id The ID of the user to update.
     * @param array $data The data to update the user with.
     * @return bool Whether the user was successfully updated or not.
     */
    public function update($request, $id)
    {
        $data = $this->getData($request, 'update');
        return $this->userRepository->update($data, $id);
    }

    /**
     * Delete a user by their ID.
     *
     * @param int $id The ID of the user to delete.
     * @return bool True if the user was successfully deleted, false otherwise.
     */
    public function delete($id)
    {
        return $this->userRepository->delete($id);
    }

    public function updateFields(int $id, array $fields, $request)
    {
        try {
            DB::beginTransaction();
            $data = [];
            foreach ($fields as $fieldName) {
                $val = data_get($request, $fieldName);
                if($val){
                    $data[$fieldName] = $val;
                }
            }
            if(!empty($data)){
                $user = $this->userRepository->update($data, $id);
            }
            DB::commit();
            return $user ?? null;
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }

    public function changePassword($request){
        $user = Auth::user();
        if (!Hash::check($request->current_password, $user->password)) {
            throw new CustomException("Mật khẩu cũ không đúng", 404);
        }
        $data['password'] = Hash::make($request->new_password);
        return $this->userRepository->update($data, $user->id);
    }

    public function getData($request, $action){
        $data = array(
            'name' => $request->name,
        );
        if($action == 'create'){
            $data['password'] =  Hash::make($request->password);
        }
        return $data;
    }
}
