<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Game extends Model
{
    use HasFactory;


    /**
     * Get the home team that played the game.
     */
    public function teamHome()
    {
        return $this->belongsTo(Team::class, 'team_a_id');
    }

    /**
     * Get the away team that played the game.
     */
    public function teamAway()
    {
        return $this->belongsTo(Team::class, 'team_b_id');
    }

    /**
     * Get the winning team of the game.
     *
     * @return mixed
     */
    public function getWinTeamAttribute()
    {
        if ($this->team_a_score > $this->team_b_score) {
            return $this->teamHome;
        }

        if ($this->team_a_score < $this->team_b_score) {
            return $this->teamAway;
        }

        return null; // No team won, it's a tie
    }
}
