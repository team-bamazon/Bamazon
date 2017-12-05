class UsersController < ApplicationController
  before_action :set_user, only: [:user_info, :edit_name, :edit_email, :new_phone_number, :edit_password, :edit, :update]

  def index
  end

  def user_info
  end

  def edit_name
  end

  def edit_email
  end

  def new_phone_number
  end

  def edit_password
  end

  def edit
  end



  def set_user
    @user = User.find(params[:user_id])
  end
end
