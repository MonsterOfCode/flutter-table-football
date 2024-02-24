<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Player;
use App\Models\Team;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $players = Player::factory(50)->create();
        $teams = Team::factory(20)->create();

        // For each team, attach 1 or 2 random players
        $teams->each(function ($team) use ($players) {
            // Get 1 or 2 random player IDs
            $randomPlayers = $players->random(rand(1, 2))->pluck('id');

            // Attach the players to the team
            $team->players()->attach($randomPlayers);
        });

        $this->call([
            GamesTableSeeder::class,
        ]);
    }
}
