class Event < ApplicationRecord
  validates :start_date, presence: true, comparison: { greater_than_or_equal_to: Time.now }
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates_with Validators::DivisibleByFiveValidator
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { in: 1..1000 }
  validates :location, presence: true
  has_many :participations
  has_many :participants, class_name: 'User', through: :participations
  belongs_to :organiser, class_name: 'User', foreign_key: 'organiser_id'
end
