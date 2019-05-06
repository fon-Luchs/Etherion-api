class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :messageable, polymorphic: true
      t.references :user, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
