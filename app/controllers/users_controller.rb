class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :destroy, :update]
  before_filter :authenticate_user!
  before_filter :authenticate_admin!, only: :destroy
  layout "photos"
  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User destroyed."
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    params_user = params[:user]
    if !@user.valid_password?(params_user[:current_password])
      redirect_to edit_user_path(@user), alert: "Current password incorrect."
    elsif params_user[:password] != params_user[:password_confirmation]
      redirect_to edit_user_path(@user), alert: "Passwords do not match."
    elsif @user.update_attributes(params_user.permit([:email, :password, :password_confirmation]))
      redirect_to edit_user_path(@user), notice: "User updated."
    else
      redirect_to edit_user_path(@user), alert: "Couldn't update user"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def current_user?(user)
    user == current_user
  end

end
