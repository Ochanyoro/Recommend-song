class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post,only: [:edit,:update,:destroy,:show]
  before_action :force_redirect_unless_my_post,only: [:edit,:update,:destroy]

  def index
    c = Like.group(:post_id).order("count_all DESC").count
    if c.empty?
      @posts = Post.all.order(created_at:"desc")
    else
      s = []
      for i in c
        s.push(i[0])
      end
      @posts=[]
      for i in s
        @p = Post.find(i)
        @posts.push(@p)
      end
      if s.length != Post.all.count
        @posts_2= Post.all.order(created_at:"desc")
        @posts2 = []
        for p in @posts_2
          if s.include?(p.id)
          else
            @posts2.push(p)
          end
        end
      end
    end
  end

  def show
  end

  def new
    return redirect_to new_profile_path, alert:"プロフィールを登録してください" if current_user.profile.blank?
    @post = Post.new()
    @message = @post.messages.new
  end

  def edit
  end


  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if Post.find_by(song:@post.song)
      redirect_to new_post_path,notice:"その曲はすでにあります"
    end
    if post_params[:singername].blank?
      render :new,notice:"空白の部分があります"
    else
      if Singer.find_by(name:post_params[:singername])
        sing = Singer.find_by(name:post_params[:singername])
        @post.singer = sing
        if @post.save
          redirect_to message_path(@post),notice:"投稿に成功しました"
        else
          render :new,notice:"空白の部分があります"
        end
      else
        redirect_to new_singer_path,notice:"歌手を作成してください"
      end
    end
  end

  def update
    if @post.update(post_params)
      redirect_to root_path,notice:"投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path, notice: "投稿を削除しました"
    else
      render :edit
    end
  end

  def comment
    @messages = Message.where(post_id:params[:id])
    @posts    = Post.find(params[:id])
    @post     = Post.new()
    @message  = @post.messages.new
    @singer   = Singer.find_by(id:@posts.singer_id)
  end

  private

  def post_params
    params.require(:post).permit(
      :song,:kind,:singername,:url,:image,messages_attributes: [:comment,:user_id, :_destroy, :id]
    )
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def force_redirect_unless_my_post
    return redirect_to root_path,notice:"自分の投稿ではありません" if @post.user != current_user
  end
end
