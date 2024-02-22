# Table Football Coding Challenge
This is the flutter app for a table football game.

## User Stories
1. As a user, I want to start a new game between two teams so that I can keep track of score as the game is being played.

2. As a user, I want to create a game that has already been played so that I can enter the result of that game.

3. As a user, I want to be able to create teams with one or two players so that I can reuse the teams when I create new games.

4. As a user, I want to be able to identify my self on the app or delete my account 

5. As a user, I want to see a dashboard with team and individual player statistics so that I can see who is the ultimate champion.

#
[View the full project documentation here](./docs/table-football-react-updated.pdf)
#

## Web Phone Simulation: [ Here ](https://monsterofcode.com/table_football_challenge/alpha/)
Nickname to authentication:
- player 1

## Running instructions:
1. Clone the repository
2. On flutter app folder: Flutter pub get
3. Flutter run 
4. Select the target device from list


## [Roadmap](./docs/roadmap.md)



### GoRouter
GoRouter is a package that allows us to navigate between screens in our app using URLs and route names, which simplifies navigation. I have also used it in other projects, and it meets all the requirements for this project.

### Immutable Models
The decision to use immutable models was made because it simplifies state management and makes it easier, among other reasons, such as widget rebuild optimization, for instance.

### Authentication
As it is a simple app that does not contain any sensitive data, for quick implementation, I chose to create a basic system for identifying authenticated users. This identification is based on a nickname that is unique for each player.

### Static Data
Until the app is connected to an API, it uses static data created to allow the development of features without waiting for server-side implementation. With this static data, it is possible to test all features.


