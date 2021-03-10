class AddUserToLovers < ActiveRecord::Migration[6.1]
  def change
    add_reference :lovers, :user, foreign_key: true
  end
end
