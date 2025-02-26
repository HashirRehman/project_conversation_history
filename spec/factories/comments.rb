# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text_content { Faker::Lorem.characters(number: rand(10..20)) }
    association :user
    association :project
  end
end
