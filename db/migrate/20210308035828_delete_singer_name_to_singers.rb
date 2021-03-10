class DeleteSingerNameToSingers < ActiveRecord::Migration[6.1]
  def change
    drop_table :singers
  end
end
