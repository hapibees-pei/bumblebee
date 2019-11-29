FactoryBot.define do
  factory :user do
    id { SecureRandom.uuid }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'foobar' }
    address { Faker::Lorem.word }
  end
end
