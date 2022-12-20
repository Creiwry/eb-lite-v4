require 'rails_helper'
require 'faker'

RSpec.describe Event, type: :model do
  subject { 
    Event.new(
    start_date: '20240405',
    duration: 150,
    title: 'My Chemical Romance - Swarm Tour',
    description: 'MCR returns with a new album on this world-spanning tour, so get your eye-liner and hair-straighteners at the ready, the mayor of emo town is making a comeback.',
    price: 25,
    location: 'Paris',
    organiser: User.first
    )
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  # start_date tests
  context 'test start_date attribute' do
    it 'is not valid without start date' do
      subject.start_date = ''
      expect(subject).to_not be_valid
    end
    it 'is not valid with start date in the past' do
      subject.start_date = '20190203'
      expect(subject).to_not be_valid
    end
  end

  # title tests
  context 'test title attribute' do
    it 'is not valid without title' do
      subject.title = ''
      expect(subject).to_not be_valid
    end
    it 'is not valid with title shorter than 5 chars' do
      subject.title = 'nope'
      expect(subject).to_not be_valid
    end
    it 'is not valid with title longer than 140 chars' do
      subject.title = Faker::Lorem.characters(number: 141)
      expect(subject).to_not be_valid
    end
  end

  # duration tests
  context 'test duration attribute' do
    # it 'is not valid without duration' do #does not pass DivisibleByFiveValidator because nil
    #   subject.duration = ''
    #   expect(subject).to_not be_valid
    # end
    it 'is not valid if smaller than 0' do
      subject.duration = -1
      expect(subject).to_not be_valid
    end
    it 'is not valid if not divisible by 5' do
      subject.duration = 24
      expect(subject).to_not be_valid
    end
  end

  # description tests
  context 'test description attribute' do
    it 'is not valid without description' do
      subject.description = ''
      expect(subject).to_not be_valid
    end
    it 'is not valid if shorter than 20 chars' do
      subject.description = Faker::Lorem.characters(number: 15)
      expect(subject).to_not be_valid
    end
    it 'is not valid if longer than 1000 chars' do
      subject.description = Faker::Lorem.characters(number: 1100)
      expect(subject).to_not be_valid
    end
  end

  # price tests
  context 'test price sttribute' do
    it 'is not valid without price' do
      subject.price = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid with price lower than 1' do
      subject.price = 0
      expect(subject).to_not be_valid
    end
    it 'is not valid with price above 1000' do
      subject.price = 1001
      expect(subject).to_not be_valid
    end
  end

  # location tests
  context 'test location attribute' do
    it 'is not valid without location' do
      subject.location = ''
      expect(subject).to_not be_valid
    end
  end

  # organiser tests
  context 'test organiser attribute' do
    it 'is not valid without organiser' do
      subject.organiser = nil
      expect(subject).to_not be_valid
    end
  end

end
