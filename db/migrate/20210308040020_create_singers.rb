class CreateSingers < ActiveRecord::Migration[6.1]
  def change
    create_table :singers do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
