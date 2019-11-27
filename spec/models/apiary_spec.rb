# == Schema Information
#
# Table name: apiaries
#
#  id         :uuid             not null, primary key
#  gateway_id :uuid
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  location   :jsonb            default("\"{}\""), not null
#
# Indexes
#
#  index_apiaries_on_gateway_id  (gateway_id) UNIQUE
#  index_apiaries_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Apiary, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
