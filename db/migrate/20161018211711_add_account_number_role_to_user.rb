class AddAccountNumberRoleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :account_number, :string, default: "", null: false
    add_column :users, :role, :integer, default: 0, null: false
    add_index :users, :account_number
    add_index :users, :role
  end
end
