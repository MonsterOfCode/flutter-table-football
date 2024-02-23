<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Team extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'wins', 'losses', 'points', 'goals_for', 'goals_against'];

    /**
     * Get the top teams globally based on points.
     *
     * @param int $limit Number of top teams to return.
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public static function getTopTeams($limit = 10)
    {
        return self::orderBy('points', 'DESC')->take($limit)->get();
    }


    /**
     * The players that belong to the team.
     */
    public function players()
    {
        return $this->belongsToMany(Player::class);
    }

    /**
     * Get the last games for the team.
     */
    public function lastGames()
    {
        return $this->games->latest()->take(5);
    }

    /**
     * The home games associated with the team.
     */
    public function homeGames()
    {
        return $this->hasMany(Game::class, 'team_a_id');
    }

    /**
     * The away games associated with the team.
     */
    public function awayGames()
    {
        return $this->hasMany(Game::class, 'team_b_id');
    }

    // Combine both home and away games
    public function games()
    {
        return $this->homeGames->merge($this->awayGames);
    }
}
