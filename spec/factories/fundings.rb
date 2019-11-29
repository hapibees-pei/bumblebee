FactoryBot.define do
  factory :funding do
    price_cents { Faker::Number.number(digits: 5) }
    status { "pending" }
  end
end
