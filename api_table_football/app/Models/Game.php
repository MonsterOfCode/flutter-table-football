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
}
