class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user


  validates :comment, presence:true
  has_many:lovers,dependent: :destroy



  def lover
    return Lover.find_by(message_id:self.id,user_id:current_user)
  end

end
