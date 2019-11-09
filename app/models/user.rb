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
         :recoverable, :validatable

  has_many :apiaries
  has_many :fundings
  has_many :hives, through: :fundings

  validates :name,
    length: { maximum: 200 }

  validates :address,
    length: { maximum: 240 }
end
