# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[User, Service, Order, Shipper, Recipient, Phone, Address].each do |table|
  table.delete_all
end

user_type1 = User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "secret",
    password_confirmation: "secret",
    account_type: 0 # "personal"
    # company (optional)
    # account_number (automatically generated on save)
  )

user_type2 = User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "secret",
    password_confirmation: "secret",
    account_type: 1, # "business"
    company: Faker::Company.name
    # account_number (automatically generated on save)
  )

user_type1.phones.create!(
    phone_type: Faker::Number.between(0, 2),
    phone_number: Faker::Number.number(10)
    # ext (optional)
  )

user_type2.phones.create!(
    phone_type: Faker::Number.between(0, 2),
    phone_number: Faker::Number.number(10),
    ext: Faker::Number.number(3)
  )

user_type2.phones.create!(
    phone_type: rand(0..2),
    phone_number: Faker::Number.number(10),
    # ext (optional)
  )

user_type1.addresses.create!(
    address_type: Faker::Number.between(0, 1),
    street_address: Faker::Address.street_address,
    # secondary_address (optional)
    # city (default - San Francisco)
    # state (default - California)
    zip: Faker::Address.postcode.first(5)
    # country (default - United States)
  )

user_type2.addresses.create!(
    address_type: Faker::Number.between(0, 1),
    street_address: Faker::Address.street_address,
    # secondary_address (optional)
    # city (default - San Francisco)
    # state (default - California)
    zip: Faker::Address.postcode.first(5)
    # country (default - United States)
  )

%w(ASAP Express 4-Hour 8-Hour).each do |service|
  Service.create!(
      service_name: service,
      description: Faker::Lorem.paragraph(2),
      price: Faker::Commerce.price
    )
end

order1 = user_type1.orders.create!(
    number_of_items: Faker::Number.between(1, 10).to_s,
    # special_instructions (optional)
    # shipping_reference (optional)
    # estimated_weight (default - "1")
    # signature_requirement (default - 0)
    order_total: Faker::Commerce.price,
    service_id: Service.first.id
  )

order2 = user_type1.orders.create!(
    number_of_items: Faker::Number.between(1, 10).to_s,
    # special_instructions (optional)
    # shipping_reference (optional)
    # estimated_weight (default - "1")
    # signature_requirement (default - 0)
    order_total: Faker::Commerce.price,
    service_id: Service.last.id
  )

shipper1 = order1.create_shipper!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

shipper2 = order2.create_shipper!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

recipient1 = order1.create_recipient!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

recipient2 = order2.create_recipient!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

shipper1.create_phone!(
    phone_type: rand(0..2),
    phone_number: Faker::Number.number(10)
    # ext (optional)
  )

shipper2.create_phone!(
    phone_type: rand(0..2),
    phone_number: Faker::Number.number(10)
    # ext (optional)
  )

recipient1.create_phone!(
    phone_type: rand(0..2),
    phone_number: Faker::Number.number(10)
    # ext (optional)
  )

recipient2.create_phone!(
    phone_type: rand(0..2),
    phone_number: Faker::Number.number(10)
    # ext (optional)
  )

shipper1.create_address!(
  address_type: Faker::Number.between(0, 1),
  street_address: Faker::Address.street_address,
  # secondary_address (optional)
  # city (default - San Francisco)
  # state (default - California)
  zip: Faker::Address.postcode.first(5)
  # country (default - United States)
)

shipper2.create_address!(
  address_type: Faker::Number.between(0, 1),
  street_address: Faker::Address.street_address,
  # secondary_address (optional)
  # city (default - San Francisco)
  # state (default - California)
  zip: Faker::Address.postcode.first(5)
  # country (default - United States)
)

recipient1.create_address!(
  address_type: Faker::Number.between(0, 1),
  street_address: Faker::Address.street_address,
  # secondary_address (optional)
  # city (default - San Francisco)
  # state (default - California)
  zip: Faker::Address.postcode.first(5)
  # country (default - United States)
)

recipient2.create_address!(
  address_type: Faker::Number.between(0, 1),
  street_address: Faker::Address.street_address,
  # secondary_address (optional)
  # city (default - San Francisco)
  # state (default - California)
  zip: Faker::Address.postcode.first(5)
  # country (default - United States)
)
