class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :login, null: false
      t.string :password, null: false
      t.string :password_digest
      t.string :email, null: false

      t.timestamps
    end
    add_index :users, :login
  end
end
