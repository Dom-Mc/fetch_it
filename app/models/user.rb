# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company                :string
#  account_number         :string           default(""), not null
#  account_type           :integer          default("personal"), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#

class User < ApplicationRecord
  enum account_type: {personal: 0, business: 1}

  has_many :addresses, as: :address_owner,
                     dependent: :destroy

  has_one :order, inverse_of: :user

  has_many :phones, as: :phone_owner,
                    dependent: :destroy

  has_many :recipients, through: :order

  has_many :shippers, through: :order

  # TODO: Add an order_history
  # has_many :services, through: :order_history

  # NOTE: Others available Devise modules:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable

end
