# == Schema Information
#
# Table name: fundings
#
#  id             :uuid             not null, primary key
#  status         :integer          default("0")
#  price_cents    :integer          default("0"), not null
#  price_currency :string           default("EUR"), not null
#  hive_id        :uuid
#  user_id        :uuid
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_fundings_on_hive_id  (hive_id)
#  index_fundings_on_user_id  (user_id)
#

FactoryBot.define do
  factory :funding do
    price_cents { Faker::Number.decimal(l_digits: 2) }
    status { "pending" }
  end
end
