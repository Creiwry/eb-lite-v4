class UsersController < ApplicationController
  def index

  end

  def show 
    @user = User.find(current_user.id)
    @events = Event.where(organiser: current_user).all
  end

  def create
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
   
  end

  def update
    @user = User.find(params[:id])
    user_params = params[:user]
    @user.update(first_name: user_params[:first_name], last_name: user_params[:last_name], description: user_params[:description])
    redirect_to user_path(@user.id)
  end

  def destroy
  end
end
