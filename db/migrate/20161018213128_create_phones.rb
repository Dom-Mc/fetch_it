class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.string :phone_number, limit: 10, default: "", null: false
      t.integer :phone_type, default: 0, null: false
      t.string :ext
      t.references :phone_owner, polymorphic: true

      t.timestamps
    end

    add_index :phones, :phone_number
  end
end
