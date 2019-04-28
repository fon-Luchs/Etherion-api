class AddRateToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :ads, :rate, :integer, default: 0
  end
end
