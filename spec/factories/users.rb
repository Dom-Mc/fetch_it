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

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password "secret"
    password_confirmation "secret"
    account_type Faker::Number.between(0, 1)
    # account_number (created on automatically on save)
    # company (optional)
  end
end
