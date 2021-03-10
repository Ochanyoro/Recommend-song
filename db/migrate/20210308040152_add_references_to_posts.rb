class AddReferencesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :singer, foreign_key: true
  end
end
