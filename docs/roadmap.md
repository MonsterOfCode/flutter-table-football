# Planning Roadmap

## Issues
- [ ] Create and configure flutter project

- [ ] Create screen route system

- [ ] Create navigation bar for app
    - we can use the widget bottomNavigationBar
    - [ ] Create a Empty Dashboard/Home Screen
    - [ ] Create a Empty Teams Screen
    - [ ] Create a Empty Games Screen
    - [ ] Create a Empty Profile Screen

- [ ] Create models:
    - [ ] Create Player Model
        - [string] Name (unique)
        - [int] points (to help calculate rankings)
    - [ ] Create Team Model
        - [increment] id (unique)
        - [string] Name
        - [int] wins
        - [int] losses
        - [int] points (to help  calculate rankings)
        - [double] [Calculated] Ratio (Games Played/Win)
        - [int] GF (Goals For)
        - [int] GA (Goals Against)
        - [int] [Calculated] GD (Goals Difference)
        - [List<Player>] Players
    - [ ] Create Game Model
        - [increment] (idTeam1) (Composed  Key, Unique Constraint)
        - [increment] (idTeam2) (Composed  Key, Unique Constraint)
        - [int] ScoreTeam1
        - [int] ScoreTeam2
        - [int] [computed] winTeam
        - [DateTime] DateTime
        - [bool] done

- [ ] Create searchable data for Team, player and game models

- [ ] Create searchable list widget

- [ ] Create User story 1 widgets
    - [ ] Create Team button
    - [ ] Create form to create Team
        - [ ] Prompt by team name
        - [ ] Option to check if is for 1 or 2 players
        - [ ] Selectable list to select player 1
        - [ ] Selectable list to select player 2 (Optional)
        - [ ] Option to create team
        - [ ] Navigate to Team View
    - [ ] Create Team View widgets
        - [ ] Title
        - [ ] members of team
        - [ ] Show stats about the team
            - [ ] Games Played
            - [ ] Goals For
            - [ ] Goals Against
            - [ ] Winning percentage
        - [ ] Last games played
            - [ ] Show the last X games played
            - [ ] Result of the games
            - [ ] Other team of the game

- [ ] Create User story 2 widgets
    - [ ] Title
    - [ ] My ranking compared to other players
    - [ ] Number of games played
    - [ ] GF
    - [ ] GA
    - [ ] % of wins
    - [ ] % of losses
    - [ ] My best team
        - [ ] Number of games played
        - [ ] GF
        - [ ] GA
        - [ ] Position on ranking 
        - [ ] % of wins
        - [ ] % of losses
    - [ ] Top Teams List

- [ ] Create User story 3 widgets
    - [ ] Create Game button
    - [ ] Create form to create Game
        - [ ] Selectable list to select Team 1
        - [ ] Selectable list to select Team 2
        - [ ] Option to Create and Start Game
    - [ ] Create Game View Widget
        - [ ] Title
        - [ ] Team members
        - [ ] Show stats about the team
            - [ ] Goals For
            - [ ] Goals Against
        - Game still running
            - [ ] Option increment goals of each team
            - [ ] Option to end the game manually
            - [ ] Implement auto end game
                - If the sum of the goals is 9 the game ends automatically.

- [ ] Create User story 4 widgets
    - [ ] Create a simple form that allow the user to identify himself
        - [ ] input to insert the nickname
        - [ ] Continue (create or authentication)
    - The user is already authenticated
        - [ ] button to delete account
        - [ ] input that allow edit the player nickname

- [ ] Create User story 5 widgets
    - [ ] At form to create Game
        - [ ] Add option to mark the game as finished already
        - [ ] After that request to insert game result.
        - [ ] Create Game

- [ ] Implement a statement system
    - [ ] User Story 1
    - [ ] User Story 2
    - [ ] User Story 3
    - [ ] User Story 4
    - [ ] User Story 5

- [ ] Implement a local storage system 
    - [ ] User Story 1
    - [ ] User Story 2
    - [ ] User Story 3
    - [ ] User Story 4
    - [ ] User Story 5

- [ ] Create a simple way to user identify himself in order to access to private data (like his own teams)

- [ ] Implement error validations in forms
    - [ ] Create Player form
    - [ ] Create Game form
    - [ ] User identification form

## Other Issues that was nice/important to implement
- [ ] Test
- [ ] Git hooks


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

## Extra information

### Orders
- Always by asc
- Games
    -  Order: by play DateTime
- Players
    - Order: by Name
- Teams
    - Order: by Name




