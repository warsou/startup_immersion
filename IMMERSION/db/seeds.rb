# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts '*' * 60
puts 'Seeds'
puts '*' * 60

puts ''
puts '*' * 60
puts 'Creating Newsletter'
puts '*' * 60

Newsletter.create!(
		email: 'alison.marceline@yopmail.com',
		)

puts ''
puts '*' * 60
puts 'Creating Activities'
puts '*' * 60

activities_array = ['Engineering', 'Dev.', 'Design', 'Product', 'Operations', 'BizDev', 'Growth Hacking', 'Autre']

activities_array.each { |activity|
	Activity.create!(
		name: activity,
		)
}

puts ''
puts '*' * 60
puts 'Creating Situations'
puts '*' * 60

situations_array = ['Étudiant(e)', "Jeune diplômé(e) et/ou en recherche d'emploi", 'Employé(e)', 'Autre']

situations_array.each { |situation|
	Situation.create!(
		title: situation,
		)
}

puts ''
puts '*' * 60
puts 'Creating Users (only account)'
puts '*' * 60

4.times do
	User.create!(
		email: Faker::Name.first_name + '.' + Faker::Name.last_name + '@yopmail.com',
		password: 'coucou',
		)
end
	User.create!(
		email: 'alison.marceline@yopmail.com',
		password: 'coucou',
		newsletter: Newsletter.find_by(email: 'alison.marceline@yopmail.com'),
		admin: true,
		)

puts ''
puts '*' * 60
puts 'Creating Users (account + profile)'
puts '*' * 60

5.times do
	user_first_name = Faker::Name.first_name
	user_last_name = Faker::Name.last_name
	User.create!(
		email: user_first_name.parameterize.underscore + '.' + user_last_name.parameterize.underscore + '@yopmail.com',
		password: 'coucou',
		first_name: user_first_name,
		last_name: user_last_name,
		situation: Situation.all.sample,
		formation: Faker::Job.education_level,
		activity: Activity.all.sample,
		description: Faker::Demographic.marital_status + ' ' + Faker::Demographic.sex + ' of ' + rand(18..36).to_s + '. Currently working in ' + Faker::IndustrySegments.industry + ' as ' + Faker::Company.profession + ".",
		linked_in_url: Faker::Internet.url(host: 'linkedin.com', path: "/#{user_first_name.parameterize.underscore}.#{user_last_name.parameterize.underscore}"),
		)
end

puts ''
puts '*' * 60
puts 'Creating Startups'
puts '*' * 60

10.times do
	startup_name = Faker::Company.name
	Startup.create!(
		name: startup_name,
		catch_phrase: Faker::Quote.yoda,
		website_url: Faker::Internet.url(host: "#{startup_name.parameterize.underscore}.com", path: "/"),
		description: Faker::Lorem.question + ' ' + Faker::Lorem.paragraph(sentence_count: 10),
		)
end

puts ''
puts '*' * 60
puts 'Creating Events'
puts '*' * 60

10.times do
	event_borough = rand(75001..75020).to_s
	event_city = Faker::Nation.capital_city
	Event.create!(
		title: Faker::Marketing.buzzwords.capitalize,
		start_datetime: rand(DateTime.now..DateTime.now.end_of_year),
		duration: (rand(1..36) * 5),
		description: Faker::Lorem.sentence(word_count: 20),
		short_location: 'Paris ' + event_borough.last(2),
		adress: rand(1..99).to_s + ', ' + Faker::Address.street_name,
		zip_code: event_borough,
		city: 'Paris',
		startup: Startup.all.sample,
		)
end

puts ''
puts '*' * 60
puts 'Creating Attendances'
puts '*' * 60

i = 1
10.times do
	Attendance.create!(
		user: User.find(i),
		event: Event.all.sample,
		motivation: Faker::Lorem.sentence(word_count: rand(10..20)),
		comment: Faker::Lorem.sentence(word_count: rand(5..10)),
		)
	i = i + 1
end

puts ''
puts '*' * 60
puts 'End of Seeds'
puts '*' * 60

puts ''
