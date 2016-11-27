class AccountSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :company, :slug, :account_type
  has_many :phones
  has_many :addresses
end
