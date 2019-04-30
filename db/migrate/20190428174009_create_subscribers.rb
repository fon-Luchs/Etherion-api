class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.references :subscriber,  foreign_key: { to_table: :users }
      t.references :subscribing, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :subscribers, [:subscriber_id, :subscribing_id], unique: true
  end
end
