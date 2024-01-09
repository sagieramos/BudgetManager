class UsersController < ApplicationController
  before_action :authenticate_user!

  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_unauthorized

  def index
    @users = current_user.entities
  end

  private

  def handle_unauthorized
    flash[:warning] = 'You are not authorized to access this resource. Please sign in.'
    redirect_to new_user_session_path
  end
end
