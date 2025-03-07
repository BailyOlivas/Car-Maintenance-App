class Car < ApplicationRecord
belongs_to :user

validates :oil_change_interval, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true


def oil_change_due?
  return true if last_oil_change.nil? || last_oil_change.nil?

  miles_since_last_change = odometer - last_oil_change
  miles_since_last_change >= oil_change_interval
end

def next_oil_change
  next_oil_change = last_oil_change + oil_change_interval
  next_oil_change
end
end
