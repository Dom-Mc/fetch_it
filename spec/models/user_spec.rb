# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company                :string
#  account_number         :string           default(""), not null
#  account_type           :integer          default("personal"), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#

require 'rails_helper'

require 'rails_helper'

RSpec.describe User, type: :model do

  # NOTE: Set with - first_name, last_name, email, password, password_confirmation, account_type
  let(:user) { FactoryGirl.build :user }

  it { should have_many(:addresses) }
  it { should have_many(:orders) }
  it { should have_many(:phones) }
  it { should have_many(:recipients) }
  it { should have_many(:shippers) }

  describe "devise attributes" do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:password) }
    it { is_expected.to respond_to(:password_confirmation) }
  end

  it "is valid with a first_name, last_name, email, password, password_confirmation, account_number, and account_type" do
    User.destroy_all
    user.save
    expect(user).to be_valid
  end

  it "it successfully creates a new User instance and saves it to the database" do
    User.destroy_all
    user.save
    expect(User.count).to eql(1)
  end

  describe "first_name" do
    it { is_expected.to respond_to(:first_name) }

    it "is invalid without a first_name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "is invalid when first_name has more than 50 characters" do
      user.first_name = "x" * 51
      expect(user).to_not be_valid
    end
  end

  describe "last_name" do
    it { is_expected.to respond_to(:last_name) }

    it "is invalid without a last_name" do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it "is invalid when first_name has more than 50 characters" do
      user.last_name = "x" * 51
      expect(user).to_not be_valid
    end
  end

  describe "account_type" do
    it { is_expected.to respond_to(:account_type) }

    it "is invalid without an account_type" do
      user.account_type = nil
      expect(user).to_not be_valid
    end
  end

  describe "account_number" do
    it { is_expected.to respond_to(:account_number) }

    it "is invalid without an account_number" do
      user.save # assigns a new account_number (via #set_account_number)
      user.update(account_number: " ")
      expect(user).to_not be_valid
    end

    it "is invalid without a unique account_number" do
      user.save
      user.update(account_number: "FI-000001")
      expect(user).to_not be_valid
    end
  end

  describe "company" do
    it { is_expected.to respond_to(:company) }

    it "is invalid with a company name over 250 characters" do
      user.company = "x" * 251
      expect(user).to_not be_valid
    end
  end

  describe "#generate_account_number" do
    it "returns a string with the user's id appended at the end" do
      user = User.first

      expect(user.send(:generate_account_number)).to eql("FI-00000#{user.id}")
    end

    it "returns an error if user's id is not set" do
      user = User.first
      user.id = nil

      expect{user.send(:generate_account_number)}.to raise_error(TypeError)
    end
  end

  describe "#set_account_number" do
    it "returns true after successfully saving the user's account_number" do
      user.save
      user.account_number = nil
      expect(user.send(:set_account_number)).to be(true)
    end

    it "sets the user's account_number updates the user" do
      user = User.first
      user.account_number = nil
      user.send(:set_account_number)

      expect(user.account_number).to eql("FI-00000#{user.id}")
    end
  end

end
