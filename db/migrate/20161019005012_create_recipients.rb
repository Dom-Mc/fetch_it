class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|
      # t.belongs_to :user, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.string :first_name, default: "", null: false
      t.string :last_name, default: "", null: false
      # t.belongs_to :account, foreign_key: true
      t.timestamps
    end
  end
end
