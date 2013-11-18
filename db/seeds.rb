# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:email => "admin@test.com", :password => "admin169", :password_confirmation => "admin169", :role => "admin")
User.create(:email => "viewer@test.com", :password => "viewer169", :password_confirmation => "viewer169", :role => "viewer")
User.create(:email => "member@test.com", :password => "member169", :password_confirmation => "member169", :role => "member")