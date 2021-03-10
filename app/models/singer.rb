class Singer < ApplicationRecord
  has_one_attached :image
  
  has_many:posts, dependent: :destroy

  validates :name,presence:true
  validates :kind,presence:true

end
