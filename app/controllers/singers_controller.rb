class SingersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_singer,only: [:show]

  def index
    @singers = Singer.all.order(name:"desc")
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
    s= Singer.find(params[:id])
    @posts = Post.where(singer_id:s.id)
    @post = Post.new()
    @message = @post.messages.new
  end

  def new
    return redirect_to new_profile_path, alert:"プロフィールを登録してください" if current_user.profile.blank?
    @singer = Singer.new()
  end

  def create
    @singer = Singer.new(singer_params)
    if Singer.find_by(name:@singer.name)
      redirect_to new_singer_path,notice:"その歌手はすでにあります"
    end
    if @singer.save
      redirect_to new_post_path,notice:"歌手の作成に成功しました"
    else
      render :new,notice:"空白の部分があります"
    end
  end

  private

  def singer_params
    params.require(:singer).permit(
      :name,:kind,:image
    )
  end

  def find_singer
    @singer = Singer.find(params[:id])
  end
end
