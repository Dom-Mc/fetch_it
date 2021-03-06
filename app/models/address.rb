# == Schema Information
#
# Table name: addresses
#
#  id                 :integer          not null, primary key
#  address_type       :integer          default("Residence"), not null
#  street_address     :string           default(""), not null
#  secondary_address  :string
#  city               :string           default("San Francisco"), not null
#  state              :string           default("California"), not null
#  zip                :string           default(""), not null
#  country            :string           default("United States"), not null
#  address_owner_type :string
#  address_owner_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Address < ApplicationRecord

  enum address_type: { "Residence" => 0, "Business" => 1 }

  belongs_to :address_owner, polymorphic: true

  validates :address_type, presence: true,
                           inclusion: { within: %w(Residence Business) }

  validates :street_address, presence: true,
                             length: { maximum: 250 }

  validates :secondary_address, length: { maximum: 250 },
                                allow_blank: true

  validates :city, length: { maximum: 25 },
                   allow_blank: true

  validates :state, length: { maximum: 25 },
                    allow_blank: true

  validates :zip, presence: true
  validates :zip, length: { is: 5 },
                  numericality: { only_integer: true },
                    unless: "zip.blank?"

  validates :country, length: { maximum: 25 },
                      allow_blank: true
                      
end
