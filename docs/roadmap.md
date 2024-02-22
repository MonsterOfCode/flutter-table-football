# Planning Roadmap for Flutter App

This roadmap outlines the development overview plans for this project. Can and will  change as needed, but should provide a good starting point to understand where we are going with this project.

## Issues
- [x] Create and configure flutter project

- [x] Create screen route system

- [x] Create navigation bar for app
    - we can use the widget bottomNavigationBar
    - [x] Create a Empty Dashboard/Home Screen
    - [x] Create a Empty Teams Screen
    - [x] Create a Empty Games Screen
    - [x] Create a Empty Profile Screen

- [x] Create models:
    - [x] Create Player Model
        - [string] Name (unique)
        - [int] wins
        - [int] losses
        - [int] points
        - [double] [Calculated] Ratio (Games Played/Win)
        - [int] GF (Goals For)
        - [int] GA (Goals Against)
        - [int] [Calculated] matches
    - [x] Create Team Model
        - [increment] id (unique)
        - [string] Name
        - [int] wins
        - [int] losses
        - [int] points (to help  calculate rankings)
        - [double] [Calculated] Ratio (Games Played/Win)
        - [int] GF (Goals For)
        - [int] GA (Goals Against)
        - [int] [Calculated] matches
        - [List<Player>] Players
    - [x] Create Game Model
        - [increment] (id) (unique)
        - [int] (idTeam1)
        - [int] (idTeam2)
        - [int] ScoreTeam1
        - [int] ScoreTeam2
        - [int] [computed] winTeam
        - [DateTime] DateTime
        - [bool] done

- [x] Create searchable data for Team, player and game models

- [x] Create searchable list widget

- [x] Create User story 1 widgets
    - [x] Create Team button
    - [x] Create form to create Team
        - [x] Prompt by team name
        - [x] Option to check if is for 1 or 2 players
        - [x] Selectable list to select player 1
        - [x] Selectable list to select player 2 (Optional)
        - [x] Option to create team
        - [x] Navigate to Team View
    - [x] Create Team View widgets
        - [x] Title
        - [x] members of team
        - [x] Show stats about the team
            - [x] Games Played
            - [x] Goals For
            - [x] Goals Against
            - [x] Winning percentage
        - [x] Last games played
            - [x] Show the last X games played
            - [x] Result of the games
            - [x] Other team of the game

- [x] Create User story 2 widgets
    - [x] Title
    - [x] My ranking compared to other players
    - [x] Number of games played
    - [x] GF
    - [x] GA
    - [x] % of wins
    - [x] % of losses
    - [x] My best team
        - [x] Number of games played
        - [x] GF
        - [x] GA
        - [x] points 
        - [x] % of wins
    - [x] Top Teams List

- [x] Create User story 3 widgets
    - [x] Create Game button
    - [x] Create form to create Game
        - [x] Selectable list to select Team 1
        - [x] Selectable list to select Team 2
        - [x] Option to Create and Start Game
    - [x] Create Game View Widget
        - [x] Title
        - [x] Team members
        - [x] Show stats about the team
            - [x] Goals For
            - [x] Goals Against
        - Game still running
            - [x] Option increment goals of each team
            - [x] Option to end the game manually
            - [x] Implement auto end game
                - If the sum of the goals is 9 the game ends automatically.

- [x] Create User story 4 widgets
    - [x] Create List of Players
    - [x] Create Player button
    - [x] Create form to create Player
        - [x] insert name
        - [x] Option to check the availability of unique name
        - [x] Option to Create

- [x] Create User story 5 widgets
    - [x] At form to create Game
        - [x] Add option to mark the game as finished already
        - [x] After that request to insert game result.
        - [x] Create Game

- [x] Create User story 6 widgets
    - [x] Create a simple form that allow the user to identify himself
        - [x] input to insert the nickname
        - [x] Continue (create or authentication)
    - The user is already authenticated
        - [x] button to delete account
        - [x] input that allow edit the player nickname

- [x] Implement a local storage system 
    - [x] User Story 6

- [x] Implement error validations in forms
    - [x] Create Player form
    - [x] Create Game form
    - [x] User identification form

- [ ] Connect app to API
    - [ ] Refactor Player provider
    - [ ] Refactor Auth provider
    - [ ] Refactor Team provider
    - [ ] Refactor Game provider

## Other Issues that was nice/important to implement
- [ ] Test

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

## User Story 2: Create Dashboard Screen
Objective: Provide a dashboard displaying team and individual player statistics to identify top performers.
This is the US#4 from the requested US.

## Steps

1. The user is at the Dashboard Screen
2. In the dashboard the user have multiple sections with information about the games and teams.
    1. My Games
        1. % of wins
        2. % of losses 
        3. My position on based in points
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

## User Story 4: Authenticated Player
Objective: Allow users to identify (Authentication) thyself with their player profile. The users can also remove they identification (UnAuthentication).

## Steps

1. The user click on "Me" in the bottom menu.
2. If not authenticated
    1. The user insert his nickname and submit
    2. If the nickname exists is authenticated
    3. If the nickname do not exists it creates a new player with this nickname
3. If is already authenticated
    1. Can edit the nickname to change/create profile

## Required Features

1. [Screen] Dashboard
2. [Screen] Me
3. [Widget] Form to create/edit nickname
4. [Action] insert nickname
5. [Action] Submit Nickname

## User Story 5: Create a Past Game
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



