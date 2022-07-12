# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Activity.destroy_all

susan = User.create!(name: "susan", email: "susan@example.com")
james = User.create!(name: "james", email: "james@example.com")
andrew = User.create!(name: "andrew", email: "andrew@example.com")

FactoryBot.create_list(:activity, 16, category: 0)
FactoryBot.create_list(:activity, 16, category: 1)
FactoryBot.create_list(:activity, 16, category: 2)
FactoryBot.create_list(:activity, 16, category: 3)
