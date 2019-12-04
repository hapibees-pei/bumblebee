# == Schema Information
#
# Table name: apiaries
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  location   :jsonb            default("\"{}\""), not null
#
# Indexes
#
#  index_apiaries_on_user_id  (user_id)
#

FactoryBot.define do
  factory :apiary do
    id { SecureRandom.uuid }
    gateway_id { SecureRandom.uuid }
    location { Faker::Lorem.word }
  end
end
