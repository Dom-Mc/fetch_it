class OrderSerializer < ActiveModel::Serializer
  attributes :id, :number_of_items, :shipping_reference, :pickup_date

  has_one :account
  has_one :recipient
  has_one :shipper

end
