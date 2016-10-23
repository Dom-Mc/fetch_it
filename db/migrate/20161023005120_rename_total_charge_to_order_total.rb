class RenameTotalChargeToOrderTotal < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :total_charge, :order_total
  end
end
