<?php

namespace Database\Factories;

use App\Models\Team;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Team>
 */
class TeamFactory extends Factory
{

    protected $model = Team::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->unique()->word,
            'wins' => $this->faker->numberBetween(0, 50),
            'losses' => $this->faker->numberBetween(0, 50),
            'points' => $this->faker->numberBetween(0, 1500),
            'goals_for' => $this->faker->numberBetween(0, 200),
            'goals_against' => $this->faker->numberBetween(0, 200),
        ];
    }
}
