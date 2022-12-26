# frozen_string_literal: true

# Participations Controller
class ParticipationsController < ApplicationController
  before_action :authenticate_user, only: %i[new create edit update delete]

  def index
  end

  def show 
  end

  def create
    @event = Event.find(params[:event_id])
    Stripe.api_key = Rails.application.credentials[:stripe][:private_key]

    success_url = url_for(controller: 'successes',
                          action: 'show',
                          event_id: @event.id,
                          host: ENV["HOST_URL"])


    @event_price_id = Stripe::Price.create({
      unit_amount: @event.price * 100,
      currency: 'eur',
      product: @event.product
      })
    current_user.set_payment_processor :stripe
    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: @event_price_id,
      success_url: success_url
      )

    begin
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_participation_path
    end

    @user = current_user
    @stripe_customer = Stripe::Customer.create({
      email: @user.email
    })

    @participation = Participation.new(
      event_id: @event.id,
      participant_id: @user.id,
      stripe_customer_id: @stripe_customer.id
    )
    
    redirect_to @checkout_session.url, allow_other_host: true

    puts @checkout_session.status

    if @participation.save
      flash[:notice] = 'Ticket successfully purchased'
    else
      render :new
    end

  end

  def new
    @event = Event.find(params[:event_id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
