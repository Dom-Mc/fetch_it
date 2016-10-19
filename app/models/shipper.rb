# == Schema Information
#
# Table name: shippers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  order_id   :integer
#  first_name :string           default(""), not null
#  last_name  :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Shipper < ApplicationRecord
  # TODO: remove user_id (order will have it)

  has_one :address, as: :address_owner,
                    dependent: :destroy

  belongs_to :order, inverse_of: :shipper

  has_one :phone, as: :phone_owner,
                  dependent: :destroy

  has_one :user, through: :order

end
