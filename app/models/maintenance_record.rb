class MaintenanceRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :car
end
