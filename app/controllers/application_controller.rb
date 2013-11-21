class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    require 'csv'

    def authenticate_admin!
        if !(authenticate_user! and current_user.role == "admin")
            flash[:error] = "You do not have permission(admin) to access that"
            redirect_to root_path
        end
    end

    def authenticate_member!
        if !(authenticate_user! and (current_user.role == "admin" || current_user.role == "member"))
            flash[:error] = "You do not have permission(member) to access that"
            redirect_to root_path
        end
    end


end