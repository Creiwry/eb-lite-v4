class Participation < ApplicationRecord
  after_create :join_event_send

  belongs_to :event
  belongs_to :participant, class_name: 'User', foreign_key: 'participant_id'

  def join_event_send
    UserMailer.join_event_email(self).deliver_now
  end
end
