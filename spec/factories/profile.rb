FactoryBot.define do
  
  factory :profile do
    username { Faker::Internet.username(separators: %w(-)) }
    superuser { [true, false].sample }
  end
end