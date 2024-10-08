# frozen_string_literal: true

desc 'Populate database with dummy room data for testing'
namespace :dev do
  task generate_dummy_rooms: :environment do
    40.times do
      name = Faker::Hobby.unique.activity
      description = "A place to discuss #{name.downcase}!"
      Room.create(
        name,
        description
      )
    end
  end
end
