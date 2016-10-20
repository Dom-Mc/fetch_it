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
end
