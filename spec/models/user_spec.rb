require 'rails_helper'

RSpec.describe User, type: :model do
  subject = User.create(
    first_name: 'Creiwry',
    last_name: 'Iero',
    email: 'creiwry.iero@mychem.com',
    encrypted_password: 'secret'
  )

  it 'sends an email' do
    expect { subject.welcome_send }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
