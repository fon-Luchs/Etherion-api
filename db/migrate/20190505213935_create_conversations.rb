class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :sender, foreign_key: { to_table: :users }

      t.references :recipient, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :conversations, [:recipient_id, :sender_id], unique: true
  end
end
