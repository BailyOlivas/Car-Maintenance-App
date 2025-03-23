class AddNicknameToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :nickname, :string
  end
end
