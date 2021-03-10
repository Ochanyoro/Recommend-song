class RemoveUserToLikes < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :likes, :profiles
    remove_reference :likes, :profile, index: true
    add_reference    :likes, :user, foreign_key: true

  end
end
