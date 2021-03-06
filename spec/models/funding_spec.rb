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

require 'rails_helper'

RSpec.describe Funding, type: :model do
  it { should belong_to(:hive) }
  it { should belong_to(:user) }
  it { should define_enum_for(:status).with_values({ cart: 0, pending: 1, completed: 2 }) }
  it { validate_numericality_of(:price_cents).is_greater_than(0) }
end
