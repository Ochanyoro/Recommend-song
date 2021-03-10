class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many:posts, dependent: :destroy
  has_many:likes, dependent: :destroy
  has_many:lovers,dependent: :destroy
  has_many:messages,dependent: :destroy

  delegate :content,:image,to: :profile
end
