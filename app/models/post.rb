require 'bigdecimal'

class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :singer

  has_many:messages,dependent: :destroy
  has_many:likes,dependent: :destroy

  validates :song,presence:true
  validates :kind,presence:true
  validates :url,presence:true
  validates :singername,presence:true

  accepts_nested_attributes_for :messages, allow_destroy: true


  def comment
    return Message.find_by(post_id:self.id)
  end

  def average
    c = Like.group(:post_id).order("count_all DESC").count
    if c.empty?
      return 1.0
    else
      c = c.first[1]
      n = Like.where(post_id:self.id).count
      answer=  n.to_f/c.to_f
      return BigDecimal(answer.to_s).floor(2).to_f
    end
  end
end
