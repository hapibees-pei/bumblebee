# == Schema Information
#
# Table name: jwt_blacklist
#
#  id  :integer          not null, primary key
#  jti :string           not null
#  exp :datetime         not null
#
# Indexes
#
#  index_jwt_blacklist_on_jti  (jti)
#

class JwtBlacklist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Blacklist

  self.table_name = "jwt_blacklist"
end
