class EventsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :delete]
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

    if @event.save
      redirect_to event_path(@event.id)
    else

      render :new
    end

    
  end

  def edit
    @user = current_user
    @event = Event.find(params[:id])
    unless @event.organiser_id == @user.id
      flash[:danger] = 'You\'re not the organiser for this event'
      redirect_to event_path(@event.id)
    end
  end

  def update
    @user = current_user
    @event = Event.find(params[:id])

    unless @event.organiser_id == @user.id
      flash[:danger] = 'You\'re not the organiser for this event'
      redirect_to event_path(@event.id)
    end

    event_params = params[:event]
    update = @event.update(
      title: event_params[:title],
      description: event_params[:description],
      start_date: event_params[:start_date],
      duration: event_params[:duration],
      price: event_params[:price],
      location: event_params[:location]
    )

    if update == false
      render :edit

    else
      redirect_to event_path(@event.id) 

    end
  end

  def destroy
    @user = current_user
    @event = Event.find(params[:id])

    unless @event.organiser_id == @user.id
      flash[:danger] = 'You\'re not the organiser for this event'
      redirect_to event_path(@event.id)
    end

    @event.destroy
    redirect_to user_path(@user.id)
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = 'Please log in.'
      redirect_to new_user_session_path
    end
  end
end
