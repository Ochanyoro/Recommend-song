class DelteAllToLovers < ActiveRecord::Migration[6.1]
  def change
    drop_table :lovers
  end
end
