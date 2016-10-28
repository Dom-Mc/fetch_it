class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :total_charge, default: "0.0", null: false
      t.string :number_of_items, default: "1", null: false
      t.string :special_instructions
      t.string :shipping_reference
      t.string :estimated_weight, default: "1", null: false
      t.integer :signature_requirement, default: 0, null: false

      t.belongs_to :account, foreign_key: true
      # t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    add_index :orders, :shipping_reference
  end
end
