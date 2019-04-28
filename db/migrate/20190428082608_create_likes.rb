class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, index: true
      t.references :likeable, polymorphic: true
      t.integer :kind, default: 0

      t.timestamps
    end
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
  end
end
