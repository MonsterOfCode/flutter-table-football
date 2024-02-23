<?php

namespace Database\Factories;

use App\Models\Game;
use App\Models\Team;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Game>
 */
class GameFactory extends Factory
{

    protected $model = Game::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // First, generate a score for the team a
        $team_a_score = $this->faker->numberBetween(0, 9);

        // Ensure the total score does not exceed 9
        $team_b_score = $this->faker->numberBetween(0, 9 - $team_a_score);

        return [
            'team_a_id' => Team::factory(),
            'team_b_id' => Team::factory(),
            'team_a_score' => $team_a_score,
            'team_b_score' => $team_b_score,
            'done' => $this->faker->boolean,
            'game_date' => $this->faker->dateTimeThisYear(),
        ];
    }
}
