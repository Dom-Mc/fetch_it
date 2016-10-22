# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161021204438) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "address_type",       default: 0,               null: false
    t.string   "street_address",     default: "",              null: false
    t.string   "secondary_address"
    t.string   "city",               default: "San Francisco", null: false
    t.string   "state",              default: "California",    null: false
    t.string   "zip",                default: "",              null: false
    t.string   "country",            default: "United States", null: false
    t.string   "address_owner_type"
    t.integer  "address_owner_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["address_owner_type", "address_owner_id"], name: "index_addresses_on_address_owner_type_and_address_owner_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_charge",          default: "0.0", null: false
    t.string   "number_of_items",       default: "1",   null: false
    t.string   "special_instructions"
    t.string   "shipping_reference"
    t.string   "estimated_weight",      default: "1",   null: false
    t.integer  "signature_requirement", default: 0,     null: false
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "service_id"
    t.index ["service_id"], name: "index_orders_on_service_id"
    t.index ["shipping_reference"], name: "index_orders_on_shipping_reference"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "phone_number",     limit: 10, default: "", null: false
    t.integer  "phone_type",                  default: 0,  null: false
    t.string   "ext"
    t.string   "phone_owner_type"
    t.integer  "phone_owner_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["phone_number"], name: "index_phones_on_phone_number"
    t.index ["phone_owner_type", "phone_owner_id"], name: "index_phones_on_phone_owner_type_and_phone_owner_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.string   "first_name", default: "", null: false
    t.string   "last_name",  default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["order_id"], name: "index_recipients_on_order_id"
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string   "service_name", default: "",    null: false
    t.text     "description",  default: "",    null: false
    t.decimal  "price",        default: "0.0", null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["service_name"], name: "index_services_on_service_name"
  end

  create_table "shippers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.string   "first_name", default: "", null: false
    t.string   "last_name",  default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["order_id"], name: "index_shippers_on_order_id"
    t.index ["user_id"], name: "index_shippers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "company"
    t.string   "account_number",         default: "", null: false
    t.integer  "account_type",           default: 0,  null: false
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "provider"
    t.string   "uid"
    t.index ["account_number"], name: "index_users_on_account_number"
    t.index ["company"], name: "index_users_on_company"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

end
