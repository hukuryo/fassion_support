class Customers::CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]

    def create
        @post = Post.find(params[:post_id])
        comment = current_user.comments.new(comments_params)
        comment.post_id = @post.id
        if comment.save
            flash[:notice] = "コメントしました！"
            redirect_to post_path(@post)
        else
            flash[:alert] = "内容が空白です"
            redirect_to post_path(@post)
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        if Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
            flash[:alert] = "コメントを削除しました！"
            redirect_to post_path(@post)
        else
            redirect_to post_path(@post)
        end
    end

private

    def comments_params
        params.require(:comment).permit(:text, :post_id).merge(user_id: current_user.id)
    end

end