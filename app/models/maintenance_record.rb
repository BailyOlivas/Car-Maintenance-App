class MaintenanceRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :car

  enum :service_type, oil_change: 0, brake_inspection: 1
  validates :service_date, presence: true

  after_create :update_car_odometer, :update_car_last_oil_change


  private

  def update_car_odometer
    if car.odometer.nil? || miles > car.odometer
      car.update(odometer: miles)
    end
  end


  def update_car_last_oil_change
    if oil_change?
      car.update(last_oil_change: miles)
    end
  end
end
