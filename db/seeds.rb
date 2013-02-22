# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = %w(Ferdinand Ezekial Barney Sycorax Blimpy Lars Bubbles Trickster Creature Dyane Shadow Margaret Billy Rokzor Sprinkles Tug Wubbles Chester Miles Mittens)
r = Random.new

20.times do |n|
  puts "#{Dir.pwd}"
  file = File.open("#{Dir.pwd}/app/assets/images/#{n + 1}.jpeg")
  Item.create(:name => names[n],
              :price => r.rand(20...62),
              :image => file.read())
end