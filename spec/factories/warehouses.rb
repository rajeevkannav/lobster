FactoryBot.define do
  factory(:warehouse) do
    name { Faker::Address.city }
  end
end

