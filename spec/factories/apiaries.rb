FactoryBot.define do
  factory :apiary do
    id { SecureRandom.uuid }
    gateway_id { SecureRandom.uuid }
    location { Faker::Lorem.word }
  end
end