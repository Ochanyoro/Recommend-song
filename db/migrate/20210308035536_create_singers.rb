class CreateSingers < ActiveRecord::Migration[6.1]
  def change
    create_table :singers do |t|
      t.references :post, null: false, foreign_key: true
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
