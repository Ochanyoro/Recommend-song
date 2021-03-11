class CreateLovers < ActiveRecord::Migration[6.1]
  def change
    create_table :lovers do |t|
      t.references :message, null: false, foreign_key: true
      t.integer :good
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
