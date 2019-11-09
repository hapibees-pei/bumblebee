# == Schema Information
#
# Table name: hives
#
#  id           :uuid             not null, primary key
#  name         :string           default("")
#  description  :text
#  bee_number   :integer
#  sensor_id    :uuid
#  status       :integer          default("0")
#  success_rate :integer          default("0")
#  apiary_id    :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_hives_on_apiary_id  (apiary_id)
#

require 'rails_helper'

RSpec.describe Hive, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
