class UsersController < ApplicationController
  def index
  end

  def user_info
    @user = User.find(params[:user_id])
  end

  def edit_name
    @user = User.find(params[:user_id])
  end

  def edit
  end
end
