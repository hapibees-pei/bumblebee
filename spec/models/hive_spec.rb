# == Schema Information
#
# Table name: hives
#
#  id           :uuid             not null, primary key
#  name         :string           default("")
#  description  :text
#  bee_number   :integer
#  status       :integer          default("0")
#  success_rate :integer          default("0")
#  apiary_id    :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sensor_id    :integer
#
# Indexes
#
#  index_hives_on_apiary_id  (apiary_id)
#

require 'rails_helper'

RSpec.describe Hive, type: :model do
  it { should have_many(:fundings) }
  it { should belong_to(:apiary) }
  it { should define_enum_for(:status).with_values({ healthy: 0, perished: 1 }) }
end
