# == Schema Information
#
# Table name: phones
#
#  id               :integer          not null, primary key
#  phone_number     :string(10)       default(""), not null
#  phone_type       :integer          default("mobile"), not null
#  ext              :string
#  phone_owner_type :string
#  phone_owner_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Phone < ApplicationRecord
  enum phone_type: { "Mobile" => 0, "Home" => 1, "Office" => 2 }

  before_validation :sanitize_phone_number

  belongs_to :phone_owner, polymorphic: true

  validates :phone_type, presence: true,
                         inclusion: { within: %w(Mobile Home Office) }

  validates :phone_number, presence: true
  validates :phone_number, length: { is: 10 },
                           numericality: { only_integer: true },
                             unless: "phone_number.blank?"

  validates :ext, length: { maximum: 10 },
                  numericality: { only_integer: true },
                  allow_blank: true

  private

    def sanitize_phone_number
      self.phone_number = phone_number&.gsub(/\D/, '')
    end
end
