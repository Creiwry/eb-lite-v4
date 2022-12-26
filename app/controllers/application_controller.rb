class ApplicationController < ActionController::Base
  require 'stripe'

  def authenticate_user
    return if current_user

    flash[:danger] = 'Please log in.'
    redirect_to new_user_session_path
  end
end
