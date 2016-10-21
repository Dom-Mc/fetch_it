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
  # let(:user) { FactoryGirl.build :user }
  let(:address) { FactoryGirl.build :address }
  # let(:address) { FactoryGirl.build_stubbed :address }
  # let(:user) {build_stubbed(:user)}
  # let(:addd) {build_stubbed(:address)}
  # let(:order) {build_stubbed(:order)}

  # NOTE: Set with - address_type, street_address, zip

  # it { should belong_to(:address_owner) }


  it 'is valid with a street_address, address_type, and zip' do

    binding.pry
    Address.destroy_all
    expect(subject).to be_valid
  end

  it 'successfully creates a new Address instance and saves it to the database' do
    Address.destroy_all
    address.save
    expect(Address.count).to eql(1)
  end

  describe "address_type" do
    it { is_expected.to respond_to(:address_type) }

    it 'is invalid without an address_type' do
      address.address_type = nil
      expect(address).to_not be_valid
    end
  end

  describe "street_address" do
    it { is_expected.to respond_to(:street_address) }

    it 'is invalid without a street_address' do
      address.street_address = nil
      expect(address).to_not be_valid
    end

    it 'is invalid when street_address has more than 250 characters' do
      address.street_address = "x" * 251
      expect(address).to_not be_valid
    end
  end

  describe "secondary_address" do
    it 'is valid with a secondary_address' do
      address.secondary_address = "apartment 5"
      expect(address).to be_valid
    end

    it 'is invalid when secondary_address has more than 250 characters' do
      address.street_address = "x" * 251
      expect(address).to_not be_valid
    end
  end

  describe "city" do
    it "defaults to San Francisco" do
      address.save
      expect(address.city).to eql("San Francisco")
    end

    it 'is invalid without a city' do
      address.city = nil
      expect(address).to_not be_valid
    end

    it 'is invalid when city has more than 25 characters' do
      address.city = "x" * 26
      expect(address).to_not be_valid
    end
  end

  describe "state" do
    it "defaults to California" do
      address.save
      expect(address.state).to eql("California")
    end

    it 'is invalid without a state' do
      address.state = nil
      expect(address).to_not be_valid
    end

    it 'is invalid when a state has more than 25 characters' do
      address.state = "x" * 26
      expect(address).to_not be_valid
    end
  end

  describe "zip" do
    it 'is invalid without a zip' do
      address.zip = nil
      expect(address).to_not be_valid
    end

    it 'is invalid when a zip has more than 5 characters' do
      address.zip = "123456"
      expect(address).to_not be_valid
    end

    it 'is invalid when zip has less than 5 characters' do
      address.zip = "1234"
      expect(address).to_not be_valid
    end

    it 'is invalid when zip contains non numeric characters' do
      address.zip = "1a3-5"
      expect(address).to_not be_valid
    end
  end

  describe "country" do
    it "defaults to United States when a country is not entered" do
      address.save
      expect(address.country).to eql("United States")
    end

    it 'is invalid without a country' do
      address.country = nil
      expect(address).to_not be_valid
    end

    it 'is invalid when country has more than 25 characters' do
      address.country = "x" * 51
      expect(address).to_not be_valid
    end
  end

end
