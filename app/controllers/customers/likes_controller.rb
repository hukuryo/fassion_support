class Customers::LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save!
    redirect_to posts_path
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy!
    redirect_to posts_path
  end
  
  private
  
  def likes_params
    params.require(:like).permit(:post_id, :user_id)
  end

end
