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

## About project 

### Packages
Here there is the packages that i used in this project:

#### GoRouter
GoRouter is a package that allows us to navigate between screens in our app using URLs and route names, which simplifies navigation. I have also used it in other projects, and it meets all the requirements for this project.

#### Intl
Package used to format date times

#### Shared Preferences
To save some local data, I chose to use the package shared_preferences, which is the simplest way of saving and retrieving data from local storage. Since the data we need to store in this app involves only small amounts, the package can easily handle the situation and is very simple to use. 

### State Manager
For state management, I chose to use Flutter’s native setState, because it’s already included and can easily handle the state correctly for the current app.

### Immutable Models
The decision to use immutable models was made because it simplifies state management and makes it easier, among other reasons, such as widget rebuild optimization, for instance.

### Models and LiteModels
For improved performance during API requests and to reduce the data size loaded into memory when rendering a list of items, I chose to implement some models in lite mode also. Lite models represent the same entity but contain less data, which is requested and converted to a normal model when needed.

### Authentication
As it is a simple app that does not contain any sensitive data, for quick implementation, I chose to create a basic system for identifying authenticated users. This identification is based on a nickname that is unique for each player.

### Static Data
Until the app is connected to an API, it uses static data created to allow the development of features without waiting for server-side implementation. With this static data, it is possible to test all features.

### Folder Structure

- **assets/**: All images are stored here.
  
- **lib/**
    - **src/**: Contains all application files.
        - **core/**: Contains all the logic needed for the correct functionality of the application, including routers, mixins, extensions, utils, etc.
            - **constants/**: Contains all constants such as colors, dimensions, strings, etc.
            - **data/**: Data used for the functionality of the app.
                - **enums/**: Enums used for managing the app.
                - **models/**: abstract class used tp help managing the app.
            - **extensions/**: Extensions of widgets and data types to aid development.
                - **types/**: Extensions of data types.
                - **widgets/**: Extensions of widgets.
            - **mixins/**: Mixins used in the app.
            - **routes/**: Routes and route manager.
            - **theme/**: Styles and colors for the app.
            - **utils/**: Utility classes.
    - **data/**: Contains all models and data sources handles used in the app.
        - **models/**: Contains all data models.
            - **lite/**: Contains lightweight versions of models.
        - **providers/**: All providers responsible for requesting data from the API.
        - **repositories/**: Repositories for data management.
        - **storage/**: Storages that will get or save data locally.
    - **views/**: Contains all views of the app.
        - **dashboard/**: All views of the app with data.
            - **game/**: All views about games.
            - **player/**: All views about players.
            - **team/**: All views about teams.
        - **errors/**: Views for errors.
    - **widgets/**: Global UI widgets used by the app.
        - **create_game/**: Widgets for the "create game" view.
        - **dashboard/**: Widgets for the dashboard.
        - **list_items/**: Widgets that are list items.
        - **lists/**: Widgets that are lists.
        - **scaffolds/**: Widgets that are scaffolds.




