require 'rails_helper'

RSpec.describe Participation, type: :model do
  subject = Participation.create(
    participant: User.last,
    event: Event.last,
    stripe_customer_id: 'stilldontknowwhatthisshouldbe'
  )

  it 'sends an email' do
    expect { subject.join_event_send }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
