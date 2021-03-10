class RemoveProfileToLikes < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :likes, :users
    remove_reference :likes, :user, index: true
    add_reference    :likes, :post, foreign_key: true
  end
end
