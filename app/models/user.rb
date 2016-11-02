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

class User < ApplicationRecord

  enum role: { customer: 0, employee: 1, manager: 2 }

  has_one :account, inverse_of: :user,
                    dependent: :destroy

  validates :account_number, presence: true,
                             uniqueness: true,
                             on: :update

  after_create :set_account_number, if: "account_number.blank?"


  # NOTE: Others available Devise modules:
  # :confirmable, :lockable, :timeoutable, :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name, user.last_name = auth[:info][:name].split(/\W+/)
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  private

    # NOTE: run after User.create
    def generate_account_number
      "FI-%.6d" % id
    end

    def set_account_number
      update!(account_number: generate_account_number)
    end

end
