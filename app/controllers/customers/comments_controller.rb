class Customers::CommentsController < ApplicationController

def create
    post = Post.find(params[:post_id])
        comment = current_user.comments.new(comments_params)
        comment.post_id = post.id
    if comment.save!
        flash[:notice] = "コメントしました！"
        redirect_to post_path(post)
    else
        @comments = comment.all
        render 'index'
    end
end

def destroy
    post = Post.find(params[:post_id])
    if Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
       flash[:notice] = "コメントを削除しました！"
       redirect_to post_path(post)
    else
       render 'index'
end

private

def comments_params
    params.require(:comment).permit(:text, :post_id).merge(user_id: current_user.id)
end

end
