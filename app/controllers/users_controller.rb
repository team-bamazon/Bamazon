class UsersController < ApplicationController
  before_action :set_user, only: [:edit_name, :edit_email, :new_phone_number, :edit_password, :edit, :update]

  def index
  end

  def user_info
  end

  def edit_name
  end

  def update
    @password = current_user.password
    if @user.id == current_user.id
      @user.update(users_params)
      redirect_to user_info_user_path(current_user)
    else
      render :edit_name
    end
  end

  def edit_email
  end

  def new_phone_number
  end

  def edit_password
  end

  def edit
  end

  private

  def users_params
    params.require(:user).permit(:name, :furigana, :email, :phone_number, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
