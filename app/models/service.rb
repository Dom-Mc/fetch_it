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
  extend FriendlyId
  friendly_id :service_name, use: :slugged

  TIME_REGEX = /\A(2[0-3]|[01]?[0-9]):([0-5]?[0-9])( )?([APap][mM])?\z/

  before_save :set_service_times

  has_many :orders, inverse_of: :service

  validates :description, presence: true,
                          length: { maximum: 2000 }

  validates :end_time, presence: true

  validates :service_name, presence: true,
                           length: { maximum: 50 },
                           uniqueness: true

  validates :start_time, presence: true

  validate :service_times_are_valid

  validates :price, presence: { message: "can't be blank and should to be in the correct format (exampe: 0.00." },
                    numericality: { greater_than: 0,
                                    message: "should be greater than 0.00." }

  private

    def parsed_time(time)
      Time.zone.parse(time).strftime('%H:%M')
    end

    def set_service_times
      if !self.errors.include?(:start_time)
        self.start_time = parsed_time(start_time)
      end
      if !self.errors.include?(:end_time)
        self.end_time = parsed_time(end_time)
      end
    end

    def service_times_are_valid
      error_message = "not in the correct format (example: 11:00AM)."

      if start_time.present?
        time = start_time.gsub(/\s+/,'').downcase.match(TIME_REGEX)
        self.errors.add(:start_time, :invalid_format, message: error_message) if time.nil?
      end

      if end_time.present?
        time = end_time.gsub(/\s+/,'').downcase.match(TIME_REGEX)
        self.errors.add(:end_time, :invalid_format, message: error_message) if time.nil?
      end
    end

end
