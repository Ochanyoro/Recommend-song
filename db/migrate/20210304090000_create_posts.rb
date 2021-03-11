class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :song
      t.string :type
      t.string :url

      t.timestamps
    end
  end
end
