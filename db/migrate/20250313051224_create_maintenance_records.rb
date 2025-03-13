class CreateMaintenanceRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :maintenance_records do |t|
      t.references :car, null: false, foreign_key: true
      t.datetime :service_date
      t.string :service_type
      t.decimal :cost
      t.text :notes

      t.timestamps
    end
  end
end
