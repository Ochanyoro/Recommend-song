class RemoveImageToProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :image, :string
  end
end
