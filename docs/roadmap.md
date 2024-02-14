# Planning Roadmap

## Geral Issues to be created
- [ ] Create and configure flutter project
- [ ] Create screen route system
- [ ] Create navigation bar for app
    - we can use the widget bottomNavigationBar
    - [ ] Create a Empty Dashboard/Home Screen
    - [ ] Create a Empty Teams Screen
    - [ ] Create a Empty Games Screen
    - [ ] Create a Empty Profile Screen
- [ ] Implement a statement system
- [ ] Implement a local storage system
- [ ] Create models:
    - [ ] Create Player Model
        - [string] Name (unique)
    - [ ] Create Team Model
        - [increment] id (unique)
        - [string] Name
        - [int] wins
        - [int] losses
        - [double] [Calculated] Ratio (Games Played/Win)
        - [int] GF (Goals For)
        - [int] GA (Goals Against)
        - [int] [Calculated] GD (Goals Difference)
    - [ ] Create Game Model
        - [increment] (idTeam1) (Composed  Key, Unique Constraint)
        - [increment] (idTeam2) (Composed  Key, Unique Constraint)
        - [int] ScoreTeam1
        - [int] ScoreTeam2
        - [int] [computed] winTeam
        - [DateTime] DateTime


## User Story 1: Create a Team
Objective: Allow the creation of teams with one or two players.
This is the US#3 from the requested US.

## Steps

1. The user navigates to the teams page.
2. The user click on the option to create a new team.
3. The user is prompted to enter the team name.
4. A list of players will be displayed, from which 1 or 2 can be select at once.
5. The user can search by players using their names
6. After selecting 1 or 2 players, an option to create the team will be displayed.
7. After the team is created, the user will be navigated to the team screen.

## Required Features

1. [Action] Navigate to the teams page
2. [Screen] List of Teams
3. [Action] Create new team
4. [Action] Insert team name
5. [Widget] List of selectable players
6. [Action] Search by players
7. [Action] Search players by name
8. [Action] Select player 1 ( and 2 optional)
9. [Action] Create team
10. [Screen] Team

## Required Issues
- Create 


## User Story 2: Create Dashboard Screen
Objective: Provide a dashboard displaying team and individual player statistics to identify top performers.
This is the US#4 from the requested US.

## Steps

1. The user is at the Dashboard Screen
2. In the dashboard the user have multiple sections with information about the games and teams.
    1. My Last Games
        1. % of wins
        2. % of losses 
        3. Top 3 team that the player belongs with best results
    2. Best Teams
        1. % of wins
        2. % of losses

## Required Features

1. [Screen] Dashboard
2. [Widget] MyLastGames widget 
3. [Widget] BestTeams widget


## User Story 3: Create/Start a New Game
Objective: Enable users to start a new game between two teams to track scores.
This is the US#1 from the requested US.

## Steps

1. On the home page, the user has an option to create a new game.
2. A list of teams will be displayed to select the first team for the game.
3. Then, the user must select the second team for the game.
4. During steps 2 and 3, the user has an option to create a new team if needed.
5. After selecting the 2 teams that will play, the user has the option to create and start the game.
6. The application navigates to the game page that was created.

## Required Features

1. [Screen] Dashboard
2. [Action] Create new game
3. [Widget] List of selectable teams
4. [Action] Search by teams
5. [Action] Search team by players name of team name
6. [Action] Select team 1 and team 2
7. [Action] Create and Start the game
8. [Screen] Game page



## User Story 4: Create a Past Game
Objective: Allow users to input results of games that have already been played.
This is the US#2 from the requested US.

## Steps

1. The user follows the same steps as in User Story 3 up to and including step 4.
2. The user has a checkbox to indicate if the game has already been completed.
3. After checking that option, the user is prompted to enter the result of the game.
4. The user completes the process by clicking "create."

## Required Features

1. [Screen] Dashboard
2. [Action] Create new game
3. [Widget] List of selectable teams
4. [Action] Search by teams
5. [Action] Search team by players name of team name
6. [Action] Select team 1 and team 2
7. [Action] Select the the game as already done
8. [Action] Insert the result of the game
9. [Action] Create game
10. [Screen] Game page

## Extra information

### Orders
- Always by asc
- Games
    -  Order: by play DateTime
- Players
    - Order: by Name
- Teams
    - Order: by Name




