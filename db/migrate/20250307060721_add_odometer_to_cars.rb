class AddOdometerToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :odometer, :integer
  end
end
