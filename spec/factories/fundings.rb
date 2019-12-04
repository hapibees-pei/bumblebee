FactoryBot.define do
  factory :funding do
    price_cents { Faker::Number.decimal(l_digits: 2) }
    status { "pending" }
  end
end