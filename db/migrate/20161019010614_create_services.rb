class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :service_name, default: "", null: false
      t.text :description, default: "", null: false
      t.decimal :price, default: "0.0", null: false
      t.string :start_time
      t.string :end_time
      t.string :slug
      t.timestamps
    end
    add_index :services, :slug, unique: true
    add_index :services, :service_name, unique: true
  end
end
