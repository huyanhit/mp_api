<?php

namespace Database\Factories;

use App\Models\Document\Document;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Storage;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Document>
 */
class DocumentFactory extends Factory
{
    protected $index = 0;
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $this->index++;
        $fileName = $this->faker->name();
        $type =  $this->faker->randomElement([Document::TYPE_FILE, Document::TYPE_FOLDER]);
        $userId =  $this->faker->randomDigitNotZero();
        $mimeType = '';
        $extension = '';
        $capacity = 0;
        if ($type === Document::TYPE_FILE) {
            Storage::disk('local')->put('uploads/documents/' . $fileName . '.' . $extension, 'test');
            $mimeType = $this->faker->mimeType();
            $extension = $this->faker->fileExtension();
            $capacity = $this->faker->numberBetween(0, 2147483);
        }
        $data = [
            'name' => $fileName,
            'hash_name' => sha1($fileName . $userId . microtime()),
            'user_id' => $userId,
            'type' => $type,
            'left_value' => $this->index,
            'right_value' => $this->index + 1,
            'extension' => $extension,
            'mime_type' => $mimeType,
            'path' => '/uploads/documents/' . $fileName . $extension,
            'created_by' => $userId,
            'updated_by' => $userId,
            'capacity' => $capacity,
        ];
        $this->index++;

        return $data;
    }
}
