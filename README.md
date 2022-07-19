# Swolify - Back End

## Overview

This is the Back End Application for Swolify, built in Ruby on Rails using GraphQL for communication with the Front End, built in React. This app was built in two weeks by a team of 3 back end devs. 

## Learning Goals

* Expose an API for CRUD functionality for Users, Games, and Activities in the database, to be consumed by a Front End App in React
* Use GraphQL for API endpoints / communication with the Front End

## JSON Contract

### Fetch All Users

Query:

```
query {
   fetchAllUsers{
       name
       id
       email
   }
}
```

Response: 

```
{
   "data": {
       "fetchAllUsers": [
           {
               "name": "susan",
               "id": "1",
               "email": "susan@example.com"
           },
           {
               "name": "james",
               "id": "2",
               "email": "james@example.com"
           }...
           {
               "name": "andrew",
               "id": "20",
               "email": "andrew@example.com"
           }
       ]
   }
```

### Fetch Single User

Query: 

```
query {
  fetchUser(id: 3) {
    name
    email
    wins
    losses
    gameCount
    activityCount
    games {
       completedActivities {
           name
}
        }
    }
}
```

Response: 

```
{
  "data": {
    "fetchUser": {
      "name": "Andrew",
      "email": "andrew@turing.edu",
      "wins": 1,
      "losses": 1,
      "gameCount": 2,
      "activityCount": 1,
      "activities": [
        {
          "name": "pushups"
        }
      ]
    }
  }
}
```

### Create Game

Query:

```
mutation {
  createGame(input: {params: {
    userId: 2,
    categories: ["core", "cardio"],
    level: "easy"
    }
   }
  ){
    game {
      id
      userId
      gameActivities {
        id
        activity {
          name
          description
          duration
          video
        }
      }
    }
   errors
  }  
}
```

Response:

```
{
  "data": {
    "createGame": {
      "game": {
        "userId": 2,
        "gameActivities": [
          {
            "id": "485",
            "activity": {
              "name": "prefer",
              "description": "Winston and Ferguson about to eat some pasta!",
              "duration": "Modi et iusto.",
              "video": "video.com"
            }
          },
          {
            "id": "486",
            "activity": {
              "name": "hunt",
              "description": "Winston and Ferguson about to eat some pasta!",
              "duration": "Natus voluptates tempora.",
              "video": "video.com"
            }
          }
           ....
          {
            "id": "493",
            "activity": {
              "name": "improve",
              "description": "This place is fancy and I don't know which fork to kill myself with.",
              "duration": "Omnis tenetur ipsa.",
              "video": "video.com"
            }
          }
        ]
      }
    }
errors: [ ]
  }
}
```

Parameters:

```
USERID: Integer of current users id
CATEGORIES: Array of 1 - 4 strings - [“upper body”, “lower body”, “core”, “cardio”]
LEVEL: String - “easy” or “hard”
```

### Modify Game

Query:

```
 mutation {
         modifyGame(input: { params: { 
id: 16, 
win: true, 
activities: [13, 15, 18, 22, 25] } } 
){
           game {
             id
             win
             level
           }
           success
         }
       }
```

Response:

```
{
   "data": {
       "modifyGame": {
           "game": {
               "id": "16",
               "win": true,
               "level": "easy"
           },
           "success": true
       }
   }
}
```

Parameters:

```
ID: Integer of current game id
WIN: Boolean - true or false, if game was won
ACTIVITIES: Array of integers/ids of activities *COMPLETED* in game (corresponds with game_activity id)
```

## Database Schema

![Screen Shot 2022-07-19 at 3 43 46 PM](https://user-images.githubusercontent.com/93609855/179854173-1763eae5-8750-4fb7-9e85-97146dfef2d0.png)

## GraphQL Types

### UserType

```
UserType {
	id: ID!
	name: String!
  email: String!
  wins: Integer!
  losses: Integer!
  gameCount: Integer!
  activityCount: Integer!
  games: [GameType]
  activities: [ActivityType]
}
```

### GameType

```
GameType {
	id: ID!
	win: Boolean!
	userId: Integer!
	level: String!
	activities: [ActivityType]
	completedActivities: [ActivityType]
	gameActivities: [GameActivityType]
	createdAt: Types::ISO8601DateTime
}
```

### ActivityType

```
ActivityType {
  id: ID!
  name: String!
  category: String!
  duration: String!
  video: String!
  description: String!
}
```

### GameActivityType

```
GameActivityType {
	id: ID!
	activityId: Integer!
	gameId: Integer!
	completed: Boolean!
	activity: ActivityType
}
```

## Contributors:

### Susan Boyd - [GitHub](https://github.com/sueboyd922) | [LinkedIn](https://www.linkedin.com/in/susan-boyd-6ba8749b/)
### James Harkins - [GitHub](https://github.com/James-Harkins) | [LinkedIn](https://www.linkedin.com/in/james-harkins-co/)
### Andrew Speth - [GitHub](https://github.com/aspeth) | [LinkedIn](https://www.linkedin.com/in/andrew-speth/)
