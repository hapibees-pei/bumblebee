FactoryBot.define do
  factory :user do
    id { SecureRandom.uuid }
    name { Faker::Lorem.word }
    email { 'foo@bar.com' }
    password { 'foobar' }
    address { Faker::Lorem.word }
  end
end