class AddLastOilChangeToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :last_oil_change, :integer
  end
end
