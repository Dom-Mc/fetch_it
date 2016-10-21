# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  total_charge          :decimal(, )      default(0.0), not null
#  number_of_items       :string           default("1"), not null
#  special_instructions  :string
#  shipping_reference    :string
#  estimated_weight      :string           default("1"), not null
#  signature_requirement :integer          default("no_signature"), not null
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do

  # NOTE: Set with - default values
  Service.delete_all
  let(:order) { FactoryGirl.build_stubbed :order }
  let(:saved_order) { FactoryGirl.build :order }

  it { is_expected.to have_one(:recipient) }
  it { is_expected.to belong_to(:service) }
  it { is_expected.to have_one(:shipper) }
  it { is_expected.to belong_to(:user) }

  it 'is valid with a name, description, and a price' do
    Service.delete_all
    Order.delete_all
    expect(saved_order).to be_valid
  end

  it 'successfully creates a new Order instance and saves it to the database' do
    Order.delete_all
    Service.delete_all
    saved_order.save
    expect(Order.count).to eql(1)
  end

  describe "estimated_weight" do
    it { is_expected.to respond_to(:estimated_weight) }

    it "is invalid without an estimated_weight" do
      order.estimated_weight = nil
      expect(order).to_not be_valid
    end

    # it { is_expected.to validate_numericality_of(:estimated_weight).is_greater_than(1) }
  end

  describe "number_of_items" do
    it { is_expected.to respond_to(:number_of_items) }

    it "is invalid without a number_of_items" do
      order.number_of_items = nil
      expect(order).to_not be_valid
    end

    # it {
    #   is_expected.to validate_numericality_of(:number_of_items).is_greater_than(1) }
  end

  describe "shipping_reference" do
    it { is_expected.to respond_to(:shipping_reference) }

    it "is invalid when shipping_reference has more than 50 characters" do
      order.shipping_reference = "x" * 51
      expect(order).to_not be_valid
    end
  end

  describe "signature_requirement" do
    it { is_expected.to respond_to(:signature_requirement) }

    it "is invalid without an signature_requirement" do
      binding.pry
      order.signature_requirement = nil
      expect(order).to_not be_valid
    end
  end

  describe "special_instructions" do
    it { is_expected.to respond_to(:special_instructions) }

    it "is invalid when special_instructions has more than 2000 characters" do
      order.special_instructions = "x" * 2001
      expect(order).to_not be_valid
    end
  end

  describe "total_charge" do
    it { is_expected.to respond_to(:total_charge) }

    # it 'is invalid without a total_charge' do
    #   binding.pry
    #   order.total_charge = nil
    #   expect(order).to_not be_valid
    # end

    # it 'defaults to 0.0 if total_charge is not included' do
    #   Service.delete_all
    #   saved_order.total_charge = nil
    #   saved_order.save
    #   expect(saved_order.total_charge).to_be eql(0.0)
    # end

    # it { is_expected.to validate_numericality_of(:total_charge).is_greater_than_or_equal_to(0) }
  end

end
