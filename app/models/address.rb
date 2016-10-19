class Address < ApplicationRecord
  belongs_to :address_owner, polymorphic: true
end
