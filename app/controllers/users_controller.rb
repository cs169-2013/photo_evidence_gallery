class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!, only: :destroy
  layout "photos"
  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      redirect_to users_url_path, alert: "Can't delete yourself."
    else
      user.destroy
      redirect_to users_url_path, notice: "User destroyed."
    end
  end

  private
  def current_user?(user)
    user == current_user
  end

end
