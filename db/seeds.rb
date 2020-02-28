# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Account.delete_all
User.delete_all
Transaction.delete_all

u1 = User.create(email:'test1@vb.com', mobile_number: '4915222454983', password: '123123123')

u2 = User.create(email:'test2@vb.com', mobile_number: '4915222454983', password: '123123123')

Account.create(name: "savings", balance: 49.99, user_id: u1.id )
Account.create(name: "current", balance: 39.99, user_id: u2.id )