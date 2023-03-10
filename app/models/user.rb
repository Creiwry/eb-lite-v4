class User < ApplicationRecord
  pay_customer
  include Pay::Billable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send
  
  has_many :participations
  has_many :events, through: :participations

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
