class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :create_like,only: [:create,:create2,:create3]
  before_action :destroy_like,only: [:destroy,:destroy2,:destroy3]


  def create
    if @like.save
      redirect_to root_path
    else
      redirect_to root_path, notice:"投稿に失敗しました"
    end
  end

  def create2
    if @like.save
      kari = Post.find(@like.post_id)
      redirect_to singer_path(kari.singer_id)
    else
      kari = Post.find(@like.post_id)
      redirect_to singer_path(kari.singer_id), notice:"投稿に失敗しました"
    end
  end

  def create3
    if @like.save
      kari = Post.find(@like.post_id)
      redirect_to("/posts/#{kari.id}/comment")
    else
      kari = Post.find(@like.post_id)
      redirect_to("/posts/#{kari.id}/comment")
    end
  end

  def destroy
    if @like.destroy
      redirect_to root_path
    else
      redirect_to root_path, notice: "投稿を削除できませんでした"
    end
  end

  def destroy2
    if @like.destroy
      kari = Post.find(@like.post_id)
      redirect_to singer_path(kari.singer_id)
    else
      kari = Post.find(@like.post_id)
      redirect_to singer_path(kari.singer_id), notice: "投稿を削除できませんでした"
    end
  end

  def destroy3
    if @like.destroy
      kari = Post.find(@like.post_id)
      redirect_to("/posts/#{kari.id}/comment")
    else
      kari = Post.find(@like.post_id)
      redirect_to("/posts/#{kari.id}/comment")
    end
  end



  private
  def create_like
    @like = Like.new()
    @like.user = current_user
    @like.post = Post.find(params[:id])
  end

  def destroy_like
    @like = Like.find_by(post_id:params[:id],user_id:User.find_by(id:current_user).id)
  end
end
