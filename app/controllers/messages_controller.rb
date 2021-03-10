class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_message,only: [:edit,:update,:destroy]

  def show
    @messages = Message.where(post_id:params[:id])
    @post     = Post.find(params[:id])
    @message  = Message.new()
    @message.post = @post
  end

  def new
    return redirect_to new_profile_path, alert:"プロフィールを登録してください" if current_user.profile.blank?
    @message = Message.new()
  end

  def edit

  end


  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to message_path(message_params[:post_id]),notice:"投稿に成功しました"
    else
      redirect_to message_path(message_params[:post_id]),notice:"投稿に失敗しました"
    end
  end

  def update
    if @message.update(message_params)
      redirect_to message_path(message_params[:post_id]),notice:"投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @message.destroy
      redirect_to message_path(@message.post_id), notice: "投稿を削除しました"
    else
      redirect_to message_path(q), notice: "投稿を削除できませんでした"
    end
  end

  def love
    if Lover.find_by(message_id:params[:id],user_id:current_user)
      return redirect_to message_path(Message.find_by(id:params[:id])) if Lover.find_by(message_id:params[:id],user_id:current_user,good:1)
      @lover = Lover.find_by(message_id:params[:id],user_id:current_user)
      @lover.update(good:1)
      redirect_to message_path(Message.find_by(id:params[:id]).post_id)
    else
      u = User.find_by(id:current_user)
      @lover = Lover.new(user_id:u.id,message_id:params[:id],good:1)
      @lover.save
      redirect_to message_path(Message.find_by(id:params[:id]).post_id)
    end
  end

  def bad
    if Lover.find_by(message_id:params[:id],user_id:current_user)
      return redirect_to message_path(Message.find_by(id:params[:id])) if Lover.find_by(message_id:params[:id],user_id:current_user,good:0)
      @lover = Lover.find_by(message_id:params[:id],user_id:current_user)
      @lover.update(good:0)
      redirect_to message_path(Message.find_by(id:params[:id]).post_id)
    else
      u = User.find_by(id:current_user)
      @lover = Lover.new(user_id:u.id,message_id:params[:id],good:0)
      @lover.save
      redirect_to message_path(Message.find_by(id:params[:id]).post_id)
    end
  end

  def delete
    @lover = Lover.find_by(message_id:params[:id],user_id:current_user)
    if @lover.destroy
      redirect_to message_path(Message.find_by(id:params[:id]).post_id)
    else
      redirect_to message_path(Message.find_by(id:params[:id]).post_id)
    end
  end
  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(
      :comment,:post_id,:user_id
    )
  end

  def force_redirect_unless_my_post
    return redirect_to root_path,notice:"自分の投稿ではありません" if @post.user != current_user
  end
end
