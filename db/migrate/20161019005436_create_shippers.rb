class CreateShippers < ActiveRecord::Migration[5.0]
  def change
    create_table :shippers do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.string :first_name, default: "", null: false
      t.string :last_name, default: "", null: false

      t.timestamps
    end
  end
end
