<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Player extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'points'];

    /**
     * Get the top players globally based on points.
     *
     * @param int $limit Number of top teams to return.
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public static function getTopPlayers($limit = 10)
    {
        return self::orderBy('points', 'DESC')->take($limit)->get();
    }

    /**
     * Get the route key for the model.
     *
     * @return string
     */
    public function getRouteKeyName()
    {
        return 'name'; // Custom column name instead of id
    }


    /**
     * The teams that belong to the player.
     */
    public function teams()
    {
        return $this->belongsToMany(Team::class);
    }

    /**
     * Get the top teams that the player belongs.
     */
    public function topTeams($limit = 5)
    {
        return $this->teams()->orderBy('points', 'DESC')->take($limit)->get();
    }
}
