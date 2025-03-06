class AddCarsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :car, null: true, foreign_key: true
  end
end
