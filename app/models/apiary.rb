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

class Apiary < ApplicationRecord
  has_many :hives
  belongs_to :user

  validates :location, presence: true
end
