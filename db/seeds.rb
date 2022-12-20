# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require 'faker'

#User.destroy_all
Event.destroy_all
#Participation.destroy_all


50.times do
  Event.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    start_date: Faker::Time.forward,
    duration: Faker::Number.within(range: 20..300),
    price: Faker::Number.within(range: 1..1000),
    location: Faker::Address.city,
    organiser: User.all.sample
  )
end

# 100.times do
#   Participation.create(
#     event: Event.all.sample,
#     participant: User.all.sample,
#     stripe_customer_id: Faker::Lorem.characters
#   )
# end
