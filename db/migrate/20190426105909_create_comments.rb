class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :ad, foreign_key: true
      t.text :text
      t.integer :parent_id, default: 0

      t.timestamps
    end
    add_index :comments, :parent_id
  end
end
