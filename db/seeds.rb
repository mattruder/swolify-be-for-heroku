# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
GameActivity.destroy_all
Game.destroy_all

andrew = User.create!(name: "Andrew", email: "andrew@turing.edu")
james = User.create!(name: "James", email: "James@turing.edu")
susan = User.create!(name: "Susan", email: "Susan@turing.edu")

a_game_win = Game.create!(win: true, user_id: andrew.id, level: 0)
a_game_lose = Game.create!(user_id: andrew.id, level: 0)

pushups = Activity.create!(name: "pushups", category: "upper body", duration: "10 reps", video: "video.com", description: "push the earth down")

a_game_activity = GameActivity.create!(game_id: a_game_win.id, activity_id: pushups.id)

j_game = Game.create!(user_id: james.id, level: 0)

situps = Activity.create!(name: "situps", category: "upper body", duration: "10 reps", video: "video.com", description: "push the earth down")

j_game_activity = GameActivity.create!(game_id: j_game.id, activity_id: situps.id)