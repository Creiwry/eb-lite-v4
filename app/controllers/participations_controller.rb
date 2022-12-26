class ParticipationsController < ApplicationController


  def index
  end

  def show 
  end

  def create
    @user = current_user
    @event = Event.find(params[:event_id])
    @stripe_customer = Stripe::Customer.create({
      email: @user.email,
    })

    @participation = Participation.new(
      event_id: @event.id,
      participant_id: @user.id,
      stripe_customer_id: @stripe_customer.id
    )


    if @participation.save
      flash[:notice] = 'Ticket successfully purchased'
      redirect_to user_path(@user.id)
    else
      render :new
    end

  end

  def new

    @event = Event.find(params[:event_id])
    Stripe.api_key = Rails.application.credentials[:stripe][:private_key]

    @event_price_id = Stripe::Price.create({
      unit_amount: @event.price * 100,
      currency: 'eur',
      product: @event.product
      })
    current_user.set_payment_processor :stripe
    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: @event_price_id
    )
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_participation_path
    end

    if @checkout_session.status == 'succeeded'
      redirect_to :action => 'create', :event_id =>@event.id
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end