class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_posts, only: [:index, :show, :new, :edit]

  # GET /posts
  # GET /posts.json
  def index
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @chart_date = @post.tasks.joins(:category).group("categories.name").sum(:time)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.tasks.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_posts
      @posts = Post.all
      @posts_ranking = Task.joins(:category).group('categories.name').sum(:time).sort_by { |_, v| v }.reverse
      @consecutive_posts = 1

      365.times do |index|
        post = @posts.where(created_at: (Time.current - index.day).all_day).order(created_at: :desc).first
        if post.blank?
          break
        else
          @consecutive_posts += 1
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:aword, tasks_attributes: [:id, :category_id, :time, :_destroy])
    end
end
