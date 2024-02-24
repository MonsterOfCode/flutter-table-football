<?php

namespace Database\Factories;

use App\Models\Player;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Player>
 */
class PlayerFactory extends Factory
{
    protected $model = Player::class;


    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->userName,
            'wins' => $this->faker->numberBetween(0, 50),
            'losses' => $this->faker->numberBetween(0, 50),
            'points' => $this->faker->numberBetween(0, 1500),
            'goals_for' => $this->faker->numberBetween(0, 200),
            'goals_against' => $this->faker->numberBetween(0, 200),
        ];
    }
}
