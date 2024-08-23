# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name { Faker::Hobby.unique.activity }
    description { "A place to discuss #{name.downcase}" }
  end
end
