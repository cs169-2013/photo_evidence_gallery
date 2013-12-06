class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'csv'

  def authenticate_admin!
    redirect_to root_path, alert: "You do not have permission(admin) to access that" unless (authenticate_user! and current_user.role == "admin")
  end

  def authenticate_member!
    redirect_to root_path, alert: "You do not have permission(member) to access that" unless (authenticate_user! and (current_user.role == "admin" || current_user.role == "member"))
  end


end