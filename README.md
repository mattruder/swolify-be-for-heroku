# Swolify - Back End

## Overview

This is the Back End Application for [Swolify](https://swolify.github.io/swolify-fe/), built in Ruby on Rails using GraphQL for communication with the [Front End](https://github.com/Swolify/swolify-fe), built in React. This app was built in two weeks by a team of 3 back end devs. 

## App Description

Hate working out but love yelling bingo? Try Swolify! At Swolify, users play an Exercise Bingo game, selecting which forms of exercise they want to perform, and then Swolify randomly generates a number of exercises based on the difficulty setting selected by the user. The user then completes exercises one at a time, which complete randomized tiles on the Bingo board. The user then completes exercises until obtaining a Bingo.

## Learning Goals

* Expose an API for CRUD functionality for Users, Games, and Activities in the database, to be consumed by a Front End App in React
* Use GraphQL for API endpoints / communication with the Front End

## JSON Contract (GraphQL)

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
    daysInCurrentActiveStreak
    daysInLongestStreak
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
      "daysInCurrentActiveStreak": 2,
      "daysInLongestStreak": 5
      "games": [
                {
                    "win": false,
                    "completedActivities": [
		    	{
			   "name": "Jumping Jacks"
			 },
			 {
			   "name": "Drink Water"
			 },
			 {
			    "name": "Russian Twist"
			 }
		     ]
                }....
                {
                    "win": true,
                    "completedActivities": [
                        {
                            "name": "Run"
                        },
                        {
                            "name": "Push Ups"
                        },
                        {
                            "name": "Box Toe Touches"
                        },
                        {
                            "name": "Tricep Dips"
                        }
                    ]
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

Explore the Swolify API in Postman!

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/986286affd73640911b6?action=collection%2Fimport)

## Database Schema

<img width="1176" alt="Screen Shot 2022-08-14 at 6 54 21 PM" src="https://user-images.githubusercontent.com/96309924/184561761-817e79f5-99b8-4992-8dfa-aba087f5806b.png">

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
  daysInCurrentActiveStreak: Integer!
  daysInLongestStreak: Integer!
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
