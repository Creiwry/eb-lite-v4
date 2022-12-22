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

    unless current_user == @user
      flash[:alert] = 'You cannot edit this profile'
      redirect_to user_path(@user.id)
    end
   
  end

  def update
    @user = User.find(params[:id])

    unless current_user == @user
      flash[:alert] = 'You cannot edit this profile'
      redirect_to user_path(@user.id)
    end

    user_params = params[:user]
    update = @user.update(first_name: user_params[:first_name], last_name: user_params[:last_name], description: user_params[:description])
    if update == false
      render :edit
    else
      flash[:notice] = 'Profile edited successfully'
      redirect_to user_path(@user.id)
    end
  end

  def destroy
  end
end
