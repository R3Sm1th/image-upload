class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy pdf]
  require 'pdf-reader'

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to root_path, notice: "Post was successfully destroyed.", status: :see_other
  end

  def pdf
    pdf = Prawn::Document.new
    pdf.text @post.title, size: 20, style: :bold
    pdf.text @post.body
    thumbnail = StringIO.open(@post.photos[0].download)
    pdf.image thumbnail, fit: [500, 500]

    send_data(pdf.render,
              filename: "#{@post.title}.pdf",
              type: 'application/pdf',
              disposition: 'inline')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, photos: [])
    end
end
