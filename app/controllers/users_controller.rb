class UsersController < ApplicationController

  before_action :require_login
  before_action :set_user, only: [:edit, :update, :profile, :destroy, :get_email]

  def index
    if params[:id]
      @users = User.where('id < ?', params[:id]).limit(2)
    else
      @users = User.all
    end

    respond_to do |format|
    format.html
    format.js
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(users_params)
      respond_to do |format|
        format.html { redirect_to users_url }
      end
    else
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      session[:omniauth] = nil
      redirect_to root_url
    else
      redirect_to edit_user_path(@user)
    end
  end

  def profile
  end

  def matches
    @matches = current_user.friendships.where(state: 'ACTIVE').map(&:friend) + current_user.inverse_friendships.where(state: 'ACTIVE').map(&:user)
  end

  def get_email
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:interest, :bio, :location, :avatar, :date_of_birth)
  end
end
