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

class Hive < ApplicationRecord
  include Redis::Objects

  has_many :fundings
  belongs_to :apiary

  enum status: { healthy: 0, perished: 1 }

  #value :sensor_data

  def sensor_data
    Hive.redis.get("apiary:#{self.apiary.id}/sensor:#{self.sensor_id}")
  end
end
