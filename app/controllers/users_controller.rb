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
  end

  def update
  end

  def destroy
  end
end
