class UsersController < ApplicationController
  before_action :set_user, only: [:edit_name, :edit_email, :new_phone_number, :edit_password, :edit, :update_name, :update_email, :update_phone_number, :update_password]

  def index
  end

  def user_info
  end

  def edit_name
  end

  def update_name
    if @user.id == current_user.id
      @user.update(users_params)
      redirect_to user_info_user_path
    else
      render :edit_name
    end
  end

  def edit_email
  end

  def update_email
    if @user.valid_password?(params[:password])
      respond_to do |format|
        if @user.id == current_user.id
          @user.update(users_params)
          sign_in(current_user, bypass: true)
            format.html {redirect_to user_info_user_path}
        else
          format.html  {render :edit_email}
        end
      end
    else
      flash.now[:alert] = "パスワードをもう一度入力してください"
      render :edit_email
    end
  end

  def new_phone_number
  end

  def update_phone_number
    if @user.id == current_user.id
      @user.update(users_params)
      redirect_to user_info_user_path
    else
      render :new_phone_number
    end
  end

  def edit_password
  end

  def update_password
    respond_to do |format|
      if @user.id == current_user.id
        @user.update_with_password(users_params)
        sign_in(current_user, bypass: true)
          format.html {redirect_to user_info_user_path}
      else
        format.html  {render :edit_password}
      end
    end
  end

  def edit
  end
  
  def edit_address
  end

  private

  def users_params
    params.require(:user).permit(:name, :furigana, :email, :phone_number, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  end

end
