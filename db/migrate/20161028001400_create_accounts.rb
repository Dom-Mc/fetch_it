class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :slug
      t.string :first_name, default: "", null: false
      t.string :last_name, default: "", null: false
      t.string :company
      t.integer :account_type, default: 0, null: false
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end

    add_index :accounts, :slug, unique: true
  end
end
