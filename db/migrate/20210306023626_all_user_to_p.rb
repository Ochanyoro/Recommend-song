class AllUserToP < ActiveRecord::Migration[6.1]
  def change
    drop_table :messages
  end
end
