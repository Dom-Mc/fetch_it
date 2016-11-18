class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|
      t.belongs_to :order, foreign_key: true
      t.string :first_name, default: "", null: false
      t.string :last_name, default: "", null: false
      t.timestamps
    end
  end
end
