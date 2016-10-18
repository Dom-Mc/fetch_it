class User < ApplicationRecord
  # NOTE: Others available Devise modules:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable
end
