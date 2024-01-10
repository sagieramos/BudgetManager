class UsersController < ApplicationController
  before_action :authenticate_user!

  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_unauthorized

  def index
    @users = current_user.entities
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def handle_unauthorized
    flash[:warning] = 'You are not authorized to access this resource. Please sign in.'
    redirect_to new_user_session_path
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
