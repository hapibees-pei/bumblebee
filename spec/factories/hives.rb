FactoryBot.define do
  factory :hive do
    id { SecureRandom.uuid }
    name { Faker::Lorem.word }
    status { 'healthy' }
    success_rate { Faker::Number.number(digits: 1) }
    bee_number { Faker::Number.number(digits: 5) }
  end
end
