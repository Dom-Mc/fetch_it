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

require 'rails_helper'

RSpec.describe Service, type: :model do

  # NOTE: Set with - service_name, description, price
  let(:service) { FactoryGirl.build :service }

  it { is_expected.to have_many(:orders) }

  it 'is valid with a name, description, and a price' do
    Service.destroy_all
    expect(service).to be_valid
  end

  it 'successfully creates a new Service instance and saves it to the database' do
    Service.destroy_all
    service.save
    expect(Service.count).to eql(1)
  end

  describe "service_name" do
    it { is_expected.to respond_to(:service_name) }

    it 'is invalid without a service_name' do
      service.service_name = nil
      expect(service).to_not be_valid
    end

    it 'is invalid when service_name has more than 50 characters' do
      service.service_name = "x" * 51
      expect(service).to_not be_valid
    end

    it "is invalid if service_name is not unique" do
      service1_service_name = Service.first.service_name
      service.service_name = service1_service_name
      expect(service).to_not be_valid
    end
  end

  describe "description" do
    it { is_expected.to respond_to(:description) }

    it 'is invalid without a description' do
      service.description = nil
      expect(service).to_not be_valid
    end

    it 'is invalid when description has more than 2000 characters' do
      service.description = "x" * 2001
      expect(service).to_not be_valid
    end
  end

  describe "price" do
    it { is_expected.to respond_to(:price) }

    it 'is invalid without a price' do
      service.price = nil
      expect(service).to_not be_valid
    end

    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

end
