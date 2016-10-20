class AddServiceIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :service_id, :integer
    add_index :orders, :service_id
  end
end
