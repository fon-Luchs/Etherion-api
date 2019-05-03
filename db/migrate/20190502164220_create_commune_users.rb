class CreateCommuneUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :commune_users do |t|
      t.references :commune, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
