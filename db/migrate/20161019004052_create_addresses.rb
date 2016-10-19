class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :address_type, default: 0, null: false
      t.string :street_address, default: "", null: false
      t.string :secondary_address
      t.string :city, default: "San Francisco", null: false
      t.string :state, default: "California", null: false
      t.string :zip, default: "", null: false
      t.string :country, default: "United States", null: false
      t.references :address_owner, polymorphic: true

      t.timestamps
    end
  end
end
