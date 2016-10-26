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

  has_many :orders, inverse_of: :service

  validates :description, presence: true,
                          length: { maximum: 2000 }

  validates :end_time, presence: { message: "was blank or contained invalid characters." }

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }

  validates :service_name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true

  validates :start_time, presence: { message: "was blank or contained invalid characters." }

  before_save :process_time

  def string_to_hash(string)
      eval(string)
  end

  def parse_time
    [start_time, end_time].collect do |raw_time|
      time = string_to_hash raw_time
      parsed_time = "#{time[4]}:#{time[5]}"
      parsed_time << "0" if time[5] == 0
      parsed_time
    end

  end

  def set_time_attributes
    self.start_time, self.end_time = parse_time
  end

  def process_time
    set_time_attributes
  end

end
