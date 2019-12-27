# == Schema Information
#
# Table name: apiaries
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  location   :jsonb            default("\"{}\""), not null
#  ip         :string           default(""), not null
#  port       :integer          not null
#  name       :string           default(""), not null
#
# Indexes
#
#  index_apiaries_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Apiary, type: :model do
  it { should have_many(:hives) }
  it { should belong_to(:user) }
end
