class Account < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
       :first_name,
      [:first_name, :last_name],
      [:first_name, :last_name, :company]
    ]
  end

  enum account_type: { "Personal" => 0, "Business" => 1 }


  has_many :addresses, as: :address_owner,
                       dependent: :destroy

  has_many :phones, as: :phone_owner,
                    dependent: :destroy

  has_many :recipients, through: :orders

  has_many :shippers, through: :orders


  belongs_to :user, inverse_of: :account
  has_many :orders, inverse_of: :account


  validates :account_type, presence: true,
                           inclusion: { within: %w(Personal Business) }

  validates :company, length: { maximum: 250 },
                      allow_blank: true

  validates :first_name, presence: true,
                         length: { maximum: 50 }

  validates :last_name, presence: true,
                        length: { maximum: 50 }

  # TODO: add reject_if
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :phones


end
