class Customers::PostsController < ApplicationController
    before_action :set_user, only: [:likes]
    before_action :authenticate_user!, expect: [:index]

    def index
        @posts = Post.all
        @comment = Comment.new
        @comments = Comment.includes(:user)
    end

    def edit
        @post = Post.find(params[:id])
        @genres = Genre.all
        if @post.user == current_user
            render "edit"
        else
            redirect_to posts_path(@post.id)
        end
    end

    def likes
        @user = User.find(params[:id])
        likes = Like.where(user_id: @user.id).pluck(:post_id)
        @like_posts = Post.find(likes)
    end

    def new
        @post = Post.new
        @genres = Genre.all
    end

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
    end

    def create
        @post = current_user.posts.build(posts_params)
        if @post.save
           flash[:notice] = "投稿しました！"
           redirect_to posts_path
        else
           flash[:alert] = "内容を入力してください"
            @post = Post.new
            @genres = Genre.all
           render 'new'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if @post.destroy
           flash[:alert] = "投稿を削除しました！"
           redirect_to posts_path
        else
           render 'new'
        end
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(posts_params)
           flash[:notice] = "投稿を編集しました！"
           redirect_to posts_path(@post.id)
        else
           flash[:alert] = "内容を入力してください"
           render 'edit'
        end
    end

    def search
      @comment = Comment.new
      @posts = Post.search(params[:keyword])
      @keyword = params[:keyword]
      render "index"
    end

    private

    def posts_params
        params.require(:post).permit(:genre_id, :name, :image, :introduction)
    end
end