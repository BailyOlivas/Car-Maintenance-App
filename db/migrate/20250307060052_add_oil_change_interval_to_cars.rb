class AddOilChangeIntervalToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :oil_change_interval, :integer
  end
end
