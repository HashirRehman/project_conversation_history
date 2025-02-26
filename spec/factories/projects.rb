# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { Faker::Lorem.characters(number: rand(3..20)) }
    description { Faker::Lorem.sentence(word_count: 10) }
    status { :todo }
  end
end
