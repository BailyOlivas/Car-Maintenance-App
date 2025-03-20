class ChangeServiceTypeToIntegerInMaintenanceRecords < ActiveRecord::Migration[7.0]
  def up
    # First, add a new integer column temporarily
    add_column :maintenance_records, :service_type_temp, :integer

    # Convert existing string values to integer values
    MaintenanceRecord.reset_column_information
    MaintenanceRecord.find_each do |record|
      case record.service_type
      when "oil_change"
        record.update_columns(service_type_temp: 0)
      when "brake_inspection"
        record.update_columns(service_type_temp: 1)
      end
    end

    # Remove the old string column and rename the temporary column
    remove_column :maintenance_records, :service_type
    rename_column :maintenance_records, :service_type_temp, :service_type
  end

  def down
    # Rollback: Convert back to string
    add_column :maintenance_records, :service_type_temp, :string

    MaintenanceRecord.reset_column_information
    MaintenanceRecord.find_each do |record|
      case record.service_type
      when 0
        record.update_columns(service_type_temp: "oil_change")
      when 1
        record.update_columns(service_type_temp: "brake_inspection")
      end
    end

    remove_column :maintenance_records, :service_type
    rename_column :maintenance_records, :service_type_temp, :service_type
  end
end
