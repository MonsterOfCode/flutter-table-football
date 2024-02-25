# Table Football Coding Challenge
This is the Laravel API for the table football game.

## API documentation: [ Here ](https://api.table-football.monsterofcode.com/docs/api#/)

## Web Phone Simulation: [ Here ](https://app.table-football.monsterofcode.com/)

## Prerequisites:
 * PHP 8.1 or higher
 * Composer
 * DB MS (MySQL, PostgreSQL, SQLite etc.)


## Running instructions:
1. Clone the repository
2. On api folder
3. Run `composer install`command
4. Run `php artisan key:generate`command
5. Run `php artisan migrate` command
6. Set up your database connection on .env file
7. Run server with `php artisan serve` command or if you using Herd just `herd link`

## [Roadmap](./docs/roadmap.md)

## About project 

### Packages
Here there is the packages that i used in this project:

#### Scramble
This package is based on OpenAPI to generate API documentations

##### Dependencies
    `doctrine/dbal` package


### Decisions
Some of my decisions about the development of the API and DB
#### DB
1. In the Player model, I added fields that could be retrieved through queries to the teams where the player had played. However, this approach would require significantly more processing on the server. To avoid this, considering it's a small amount of data I take this approach. 


#
[View the full project documentation here](../docs/table-football-react-updated.pdf)
#
