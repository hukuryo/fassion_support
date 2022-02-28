class Customers::PostsController < ApplicationController

def index
    @posts = Post.all
    @comment = Comment.new
    @comments = Comment.all
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
    post = current_user.posts.build(posts_params)
    if post.save!
       flash[:notice] = "投稿しました！"
       redirect_to posts_new_path
    else
       @posts = post.all
       render 'new'
    end
end

def destroy
    @post = Post.find(params[:id])
    if @post.destroy!
       flash[:notice] = "投稿を削除しました！"
       redirect_to posts_path
    else
       render 'new'
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
    params.require(:post).permit(:genre_id, :name, :image, :introduction, :comment_id)
end

end