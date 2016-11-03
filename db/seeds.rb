# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[Account, User, Service, Order, Shipper, Recipient, Phone, Address].each do |table|
  table.delete_all
end

# TODO: Add role
user_type1 = User.create!(
    email: Faker::Internet.email,
    password: "secret",
    password_confirmation: "secret"
    # account_number (automatically generated on save)
  )

# TODO: Add role
user_type2 = User.create!(
    email: Faker::Internet.email,
    password: "secret",
    password_confirmation: "secret"
    # account_number (automatically generated on save)
  )

user_type1.create_account!(
  # account-type (default - "Personal")
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
  # slug (automatically generated on save)
  # company (optional)
)

user_type2.create_account!(
  account_type: 1, # "Business"
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  # slug (automatically generated on save)
  company: Faker::Company.name
)

user_type1.account.phones.create!(
    phone_type: Faker::Number.between(0, 2),
    phone_number: Faker::Number.number(10)
    # ext (optional)
  )

user_type2.account.phones.create!(
    phone_type: Faker::Number.between(0, 2),
    phone_number: Faker::Number.number(10),
    ext: Faker::Number.number(3)
  )

# user_type2.phones.create!(
#     phone_type: rand(0..2),
#     phone_number: Faker::Number.number(10),
#     # ext (optional)
#   )

user_type1.account.addresses.create!(
    address_type: Faker::Number.between(0, 1),
    street_address: Faker::Address.street_address,
    # secondary_address (optional)
    city: Faker::Address.city, # (default - San Francisco)
    state: Faker::Address.state, # (default - California)
    zip: Faker::Address.postcode.first(5),
    # country: (default - United States)
  )

user_type2.account.addresses.create!(
    address_type: Faker::Number.between(0, 1),
    street_address: Faker::Address.street_address,
    # secondary_address (optional)
    # city (default - San Francisco)
    # state (default - California)
    zip: Faker::Address.postcode.first(5)
    # country (default - United States)
  )

#end_times = %w(15:00, 13:00, 11:00, 9:00)
# %w(ASAP Express 4-Hour 8-Hour).each do |service|
#     Service.build(
#       service_name: service,
#       description: Faker::Lorem.paragraph(2),
#       price: Faker::Commerce.price,
#       start_time: '09:00',
#       end_time: '15:00'
#     )
# end

Service.create!(
  service_name: "ASAP",
  description: Faker::Lorem.paragraph(2),
  price: Faker::Commerce.price,
  start_time: '09:00',
  end_time: '15:00'
)
Service.create!(
  service_name: "Express",
  description: Faker::Lorem.paragraph(22),
  price: Faker::Commerce.price,
  start_time: '09:00',
  end_time: '13:00'
)
Service.create!(
  service_name: "4-Hour",
  description: Faker::Lorem.paragraph(22),
  price: Faker::Commerce.price,
  start_time: '09:00',
  end_time: '11:00'
)
Service.create!(
  service_name: "8-Hour",
  description: Faker::Lorem.paragraph(22),
  price: Faker::Commerce.price,
  start_time: '09:00',
  end_time: '9:00'
)

order1 = user_type1.account.orders.build(
    pickup_date: Faker::Date.between(Date.tomorrow, 1.week.from_now),
    service_id: Service.first.id,
    pickup_time: Service.first.start_time,
    number_of_items: Faker::Number.between(1, 10).to_s,
    # special_instructions (optional)
    # shipping_reference (optional)
    # estimated_weight (default - "1")
    # signature_requirement (default - 0)
    order_total: Faker::Commerce.price
  )

order2 = user_type1.account.orders.create!(
    pickup_date: Faker::Date.between(Date.tomorrow, 1.week.from_now),
    service_id: Service.last.id,
    pickup_time: Service.first.start_time,
    number_of_items: Faker::Number.between(1, 10).to_s,
    # special_instructions (optional)
    # shipping_reference (optional)
    # estimated_weight (default - "1")
    # signature_requirement (default - 0)
    order_total: Faker::Commerce.price
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
