class CreateCommunes < ActiveRecord::Migration[5.2]
  def change
    create_table :communes do |t|
      t.string :name
      t.integer :polit_bank
      t.references :creator, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
