# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Story.find_or_create_by(title: 'Elevator Conversation', text: 'Me: I started drawing comic. Ilya: What about? Me: My sad little life.')
Story.find_or_create_by(title: 'Asian Girl Driver', text: 'One time there was this big white guy who got so scared of my driving that he was screaming how he was going to die, and then he jumped out of my car.')