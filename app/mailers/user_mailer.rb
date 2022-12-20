class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to eventbrite-lite!')
  end

  def join_event_email(participation)
    @user = participation.participant
    @event = participation.event

    mail(to: @user.email, subject: 'You have joined an event!')
  end
end
