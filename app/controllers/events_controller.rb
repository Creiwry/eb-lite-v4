class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]
  def index
    @events = Event.all

  end

  def show 
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @user = current_user
    event_params = params[:event]
    @event = Event.new(
      title: event_params[:title],
      description: event_params[:description],
      start_date: event_params[:start_date],
      duration: event_params[:duration],
      price: event_params[:price],
      location: event_params[:location],
      organiser: @user
    )

    @event.save!

    if @event.save
      redirect_to event_path(@event.id)
    else

      render :new
    end

    
  end

  def edit
    @user = current_user
    @event = Event.find(params[:id])
  end

  def update
    @user = current_user
    @event = Event.find(params[:id])
    event_params = params[:user]
    @event.update(
      title: event_params[:title],
      description: event_params[:description],
      start_date: event_params[:start_date],
      duration: event_params[:duration],
      price: event_params[:price],
      location: event_params[:location]
    )

    if @event.save
      redirect_to event_path(@event.id)
    else

      render :edit
    end
  end

  def destroy
    @user = current_user
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_path(@user.id)
  end
end
