class Customers::UsersController < ApplicationController

def show
    #@hidden = 'style="display:none"'
    @users = current_user
    @posts = current_user.posts #Post.where(genre_id: params[:genre_id])
end

def edit
    @user = current_user
end

def update
    @user = current_user
    @user.update(users_params)
    redirect_to user_path(current_user)
end

private

def users_params
    params.require(:user).permit(:name)
end

end
