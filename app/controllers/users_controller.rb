class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user, only: %i[show update destroy edit]

  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_unauthorized

  def index
    @users = current_user.entities
  end

  def edit
    return if current_user == @user

    flash[:alert] = 'You are not authorized to edit this user.'
    redirect_to root_path
  end

  def show; end

  def update
    unless current_user == @user
      flash[:alert] = 'You are not authorized to update this user.'
      redirect_to root_path
      return
    end

    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to @user
    else
      flash[:alert] = "Error updating user: #{@user.errors.full_messages.join(', ')}"
      render :edit
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
