class AddSingerNameToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :singername, :string
  end
end
