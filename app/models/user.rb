# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  address                :text
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable,
  # :rememberable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  # https://github.com/waiting-for-dev/devise-jwt#session-storage-caveat
  self.skip_session_storage = [:http_auth, :params_auth]

  attr_accessor :role

  has_many :apiaries
  has_many :fundings
  #has_many :hives, through: :fundings

  after_create :add_beerole
  # TODO: Remove this
  after_create :create_apiary

  validates :name,
    length: { maximum: 200 }

  validates :address,
    length: { maximum: 240 },
    allow_nil: true

  validate :valid_role

  private

  def create_apiary
    if self.has_role?(:beekeeper)
      Apiary.create(user: self)
    end
  end

  def valid_role
    if !verify_role?(self.role)
      errors.add(:role, "needs to be a beelover or a beekeeper")
    end
  end

  def add_beerole
    if verify_role?(role)
      self.add_role(role.to_sym)
    end
  end

  def verify_role?(role)
    if role == "beelover" || role == "beekeeper"
      true
    else
      false
    end
  end
end
