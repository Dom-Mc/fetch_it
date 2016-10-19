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
  enum phone_type: { mobile: 0, home: 1, office: 2 }
  
  belongs_to :phone_owner, polymorphic: true
end
