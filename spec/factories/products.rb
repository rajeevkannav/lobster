FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    price { Faker::Number.decimal(2) }
  end
end