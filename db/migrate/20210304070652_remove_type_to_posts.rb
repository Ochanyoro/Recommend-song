class RemoveTypeToPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :type, :string
    add_column    :posts, :kind, :string

  end
end
