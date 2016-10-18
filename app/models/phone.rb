class Phone < ApplicationRecord
  belongs_to :phone_owner, polymorphic: true
end
