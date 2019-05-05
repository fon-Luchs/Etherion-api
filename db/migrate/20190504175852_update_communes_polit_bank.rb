class UpdateCommunesPolitBank < ActiveRecord::Migration[5.2]
  def change
    change_column :communes, :polit_bank, :integer, default: 0
  end
end
