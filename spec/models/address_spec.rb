# == Schema Information
#
# Table name: addresses
#
#  id                 :integer          not null, primary key
#  address_type       :integer          default("residence"), not null
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

require 'rails_helper'

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
