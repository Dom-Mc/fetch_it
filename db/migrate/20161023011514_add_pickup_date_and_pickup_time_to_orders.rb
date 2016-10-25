class AddPickupDateAndPickupTimeToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :pickup_date, :date
    add_column :orders, :pickup_time, :string

    add_index :orders, :pickup_date
  end
end
