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

  belongs_to :phone_owner, polymorphic: true

  belongs_to :phone_owner, polymorphic: true

  validates :ext, length: { maximum: 10 },
                  allow_nil: true,
                  numericality: { only_integer: true }

  validates :phone_number, length: { is: 10 },
                           numericality: { only_integer: true }#,

  validates :phone_type, inclusion: { within: %w(Mobile Home Office) }

  validates :phone_number, :phone_type, :phone_owner, presence: true, unless: -> { facebook_user? }

  private

    def facebook_user?
      self.phone_owner.provider && self.phone_owner.uid
    end
    
end
