class MaintenanceRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :car

  enum :service_type, oil_change: 0, brake_inspection: 1
  validates :service_date, presence: true
end
