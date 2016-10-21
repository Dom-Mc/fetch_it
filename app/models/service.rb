# == Schema Information
#
# Table name: services
#
#  id           :integer          not null, primary key
#  service_name :string           default(""), not null
#  description  :text             default(""), not null
#  price        :decimal(, )      default(0.0), not null
#  order_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Service < ApplicationRecord
  has_many :orders, inverse_of: :service

  validates :description, presence: true,
                        length: { maximum: 2000 }

  validates :service_name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
end
