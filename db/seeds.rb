# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "$" * 100
puts
User.destroy_all
puts "Destroyed all users in the database"
puts
puts "$" * 100
puts
Event.destroy_all
puts "Destroyed all events in the database"
puts
puts "$" * 100
puts
Attendance.destroy_all
puts "Destroyed all attendances in the database"
puts
puts "$" * 100

3.times do |i|
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "prenom.nom#{i + 1}@yopmail.com")
  sleep(0.5)
end

puts "$" * 100
puts
puts "#{User.count} users created in the database"
puts
puts "$" * 100

2.times do
  Event.create(start_date: DateTime.now + rand(10..30), duration: rand(1..4) * 30, title: Faker::Movie.quote, description: Faker::Lorem.sentence(word_count: 50 + rand(1..100)), price: rand(1..1000), location: Faker::Address.unique.city, event_admin_id: User.all.sample.id)
end

puts "$" * 100
puts
puts "#{Event.count} events created in the database"
puts
puts "$" * 100

3.times do
  Attendance.create(user: User.all.sample, event: Event.all.sample)
  sleep(0.5)
end

puts "$" * 100
puts
puts "#{Attendance.count} attendances created in the database"
puts
puts "$" * 100
