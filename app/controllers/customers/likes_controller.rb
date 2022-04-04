class Customers::LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save!
    # redirect_to post_path(@post)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy!
    # redirect_to post_path(@post)
    redirect_back(fallback_location: root_path)
  end

  private

  def likes_params
    params.require(:like).permit(:post_id, :user_id)
  end

end
