# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
User.destroy_all
Task.destroy_all

# Create Users
user1 = User.create!(
  email: "user1@example.com",
  password: "password",
  password_confirmation: "password"
)

user2 = User.create!(
  email: "user2@example.com",
  password: "password",
  password_confirmation: "password"
)

user3 = User.create!(
  email: "user3@example.com",
  password: "password",
  password_confirmation: "password"
)

# Create Tasks
Task.create!(
  name: "Task 1",
  description: "Description for task 1",
  due_date: Date.today + 5,
  status: "Draft",
  assigned_to: user2,
  assigned_by: user1,
  created_by: user1
)

Task.create!(
  name: "Task 2",
  description: "Description for task 2",
  due_date: Date.today + 10,
  status: "Open",
  assigned_to: user3,
  assigned_by: user1,
  created_by: user1
)

Task.create!(
  name: "Task 3",
  description: "Description for task 3",
  due_date: Date.today + 15,
  status: "Pending",
  assigned_to: user1,
  assigned_by: user2,
  created_by: user2
)

Task.create!(
  name: "Task 4",
  description: "Description for task 4",
  due_date: Date.today + 20,
  status: "In Progress",
  assigned_to: user1,
  assigned_by: user3,
  created_by: user3
)

Task.create!(
  name: "Task 5",
  description: "Description for task 5",
  due_date: Date.today + 25,
  status: "Completed",
  assigned_to: user2,
  assigned_by: user3,
  created_by: user3
)

puts "Seeding completed!"
