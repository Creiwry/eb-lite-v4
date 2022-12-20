# frozen_string_literal: true

#DivisibleByFiveValidator custom validator
class Validators::DivisibleByFiveValidator < ActiveModel::Validator
  def validate(record)
    return if (record.duration % 5).zero?

    record.errors.add :base, 'has to be divisible by 5'
  end
end
