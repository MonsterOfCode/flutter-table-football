# Table Football Coding Challenge
This is the Laravel API for the table football game.


#
[View the full project documentation here](../docs/table-football-react-updated.pdf)
#

## Web Phone Simulation: [ Here ](https://monsterofcode.com/table_football_challenge/alpha/)
Nickname to authentication:
- player 1

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
