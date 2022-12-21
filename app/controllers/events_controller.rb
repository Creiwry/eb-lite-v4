class EventsController < ApplicationController
  def index
    @events = Event.all

  end

  def show 
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

      redirect_to user_path(current_user.id)
    end

    
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
