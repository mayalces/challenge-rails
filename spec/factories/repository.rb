FactoryBot.define do
  
  factory :repository do
    profile
    name { Faker::Name.first_name }
    tags { %w(one, two, three, four).sample }
  end
end