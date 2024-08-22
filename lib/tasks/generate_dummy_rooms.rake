desc 'Populate database with dummy room data for testing'
namespace :dev do
  task :generate_dummy_rooms => :environment do
    40.times do
      name = Faker::Hobby.activity
      description = "A place to discuss #{name.downcase}!"
      Room.create(
        name: name,
        description: description
      )
    end
  end
end
