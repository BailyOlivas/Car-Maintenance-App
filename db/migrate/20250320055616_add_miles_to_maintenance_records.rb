class AddMilesToMaintenanceRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :maintenance_records, :miles, :integer
  end
end
