class AddRateToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :rate, :integer, default: 0
  end
end
