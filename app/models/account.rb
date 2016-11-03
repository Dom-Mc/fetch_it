# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  slug         :string
#  first_name   :string           default(""), not null
#  last_name    :string           default(""), not null
#  company      :string
#  account_type :integer          default("Personal"), not null
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Account < ApplicationRecord
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  enum account_type: { "Personal" => 0, "Business" => 1 }

  def slug_candidates
    [
       :first_name,
      [:first_name, :last_name],
      [:first_name, :last_name, :company]
    ]
  end

  has_many :addresses, as: :address_owner,
                       dependent: :destroy

  has_many :phones, as: :phone_owner,
                    dependent: :destroy

  has_many :recipients, through: :orders
  has_many :shippers, through: :orders
  belongs_to :user, inverse_of: :account
  has_many :orders, inverse_of: :account

  default_scope -> { order(created_at: :desc) }

  validates :first_name, presence: true,
                         length: { maximum: 50 }

  validates :last_name, presence: true,
                        length: { maximum: 50 }

  validates :account_type, presence: true,
                           inclusion: { within: %w(Personal Business) }

  validates :company, length: { maximum: 250 },
                      allow_blank: true

  # TODO: Fix order of display
  # validates_associated :addresses
  # validates_associated :phones

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :phones

end
