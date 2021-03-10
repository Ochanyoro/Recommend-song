class Profile < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :content, presence:true
end
