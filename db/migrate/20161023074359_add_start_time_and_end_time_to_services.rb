class AddStartTimeAndEndTimeToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :start_time, :string
    add_column :services, :end_time, :string
  end
end
