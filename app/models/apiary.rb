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

class Apiary < ApplicationRecord
  include Redis::Objects

  has_many :hives
  belongs_to :user

  value :status

  #validates :location, presence: true
  validates :ip, presence: true
  validates :port, presence: true
end
