# frozen_string_literal: true

require_relative '../services/stripe_product_creator'

# Events Controller
class EventsController < ApplicationController
  before_action :authenticate_user, only: %i[new create edit update delete]
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @number_of_participants = @event.participations.count
  end

  def new
    @event = Event.new
  end

  def create
    @user = current_user
    @event = Event.new(event_params)
    @event.organiser = @user

    if @event.save
      flash[:notice] = 'Event created successfully'
      StripeProductCreator.new(@event.id).create
      redirect_to event_path(@event.id)
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @event = Event.find(params[:id])
    return if @event.organiser_id == @user.id

    flash[:danger] = 'You\'re not the organiser for this event'
    redirect_to event_path(@event.id)
  end

  def update
    @user = current_user
    @event = Event.find(params[:id])

    unless @event.organiser_id == @user.id
      flash[:danger] = 'You\'re not the organiser for this event'
      redirect_to event_path(@event.id)
    end

    update = @event.update(event_params)

    if update == false
      render :edit
    else
      flash[:notice] = 'Event edited successfully'
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

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :location, :price)
  end
end
