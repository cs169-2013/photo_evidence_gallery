class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :destroy, :update]
  before_filter :authenticate_user!
  layout "photos"
  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
  end

  def destroy
    redirect_to edit_user_path(@user), alert: "Need to be an admin" and return unless current_user.role == "admin" || current_user == @user
    @user.destroy
    redirect_to users_path, notice: "User destroyed."
  end

  def update
    redirect_to edit_user_path(@user), alert: "Need to be an admin" and return unless current_user.role == "admin" || current_user == @user
    if should_clear_password_param
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @params_user = params[:user]
    if used_invalid_current_password
      flash[:alert] = "Current password incorrect."
    elsif passwords_do_not_match
      flash[:alert] = "Passwords do not match."
    elsif @user.update_attributes(@params_user.permit([:email, :password, :password_confirmation]))
      flash[:notice] = "User updated."
    else
      flash[:alert] = "Couldn't update user. Try a more complicated password."
    end
    redirect_to edit_user_path(@user)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def used_invalid_current_password
    !@user.valid_password?(@params_user[:current_password])
  end

  def passwords_do_not_match
    @params_user[:password] != @params_user[:password_confirmation]
  end

  def should_clear_password_param
    params[:user][:password].blank? && params[:user][:password_confirmation].blank?
  end

end
