class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @tasks  = Task.order('limit_date').all
    @tags = Post.tag_counts_on(:tags).order('count DESC')  # 全タグ(Postモデルからtagsカラムを降順で取得)

    if params[:search] == nil
      @posts = Post.all.order(id: "DESC")
    elsif params[:search] == ''
      @posts = Post.all.order(id: "DESC")
      #部分検索
    else
      @posts = Post.where("body LIKE ? ",'%' + params[:search] + '%').order(id: "DESC")
    end

    if @tag = params[:tag]
      @posts = Post.tagged_with(params[:tag]).order(id: "DESC")   # タグに紐付く投稿
    end
  end

  def new
    @post = Post.new
    @tags = @post.tag_counts_on(:tags)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to :action => "index"
    else
      flash.now[:alert] = '投稿内容を入力してください。'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tag_counts_on(:tags)
  end

  def update
    @post = Post.find(params[:id])
    tags = @post.tag_counts_on(:tags)
    if @post.update(post_params)
      redirect_to :action => "show", :id => post.id
    else
      render action: :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to action: :index
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.profile = "ゲストユーザーとしてログインしています。"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private
  def post_params
    params.require(:post).permit(:body, :tag_list)
  end

end