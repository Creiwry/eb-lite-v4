
class Services::StripeProductCreator
  def initialize(event_id)
    @event = Event.find(event_id)
  end

  def create
    Stripe.api_key = Rails.application.credentials[:stripe][:private_key]
    @product = Stripe::Product.create({name: @event.title })
    @event.update(product: @product.id)
  end
end