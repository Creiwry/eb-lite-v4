class SuccessesController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: "price_1MIVEsKE7sEAa7Yq0TXmjlZB"
    )
  end

  def create

  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
  end
end