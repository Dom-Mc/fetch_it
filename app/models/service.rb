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

class Service < ApplicationRecord
  attr_accessor :get_service_start, :get_service_end

  has_many :orders, inverse_of: :service

  validates :description, presence: true,
                          length: { maximum: 2000 }

  validates :end_time, presence: { message: "was blank or contained invalid characters." }

  validates :price, presence: true
  validates :price, numericality: { greater_than: 0, message: "must be greater than $0.00." }

  validates :service_name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true


  validates :start_time, presence: { message: "was blank or contained invalid characters." }

  before_validation :set_time, if: :times_are_present?

  def times_are_present?
    get_service_start.present? && get_service_end.present?
  end

  def times_are_valid?
    [get_service_start, get_service_end].all? do |time|
      time[4] != 0 && time[4].present? && time[5].present?
    end
  end

  def parse_time
    [get_service_start, get_service_end].map do |raw_time|
      parsed_time = "#{raw_time[4]}:#{raw_time[5]}"
      parsed_time << "0" if raw_time[5] == 0
    end
  end

  def set_time
    self.start_time, self.end_time = parse_time
  end

end
