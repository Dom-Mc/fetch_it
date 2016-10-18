class AddCompanyAccountNumberAccountTypeFirstNameLastNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :company, :string
    add_column :users, :account_number, :string, default: "", null: false
    add_column :users, :account_type, :integer, default: 0,  null: false
    add_column :users, :first_name, :string, default: "", null: false
    add_column :users, :last_name, :string, default: "", null: false

    add_index :users, :company
    add_index :users, :account_number
  end
end
