module Api
  module V1
    class Api::V1::MaintenanceRecordsController < Api::V1::BaseController
      before_action :authenticate_user!
      def index
        @maintenance_records = current_user.maintenance_records
        logs = @maintenance_records
        render json: logs
      end

      def create
        # The URL should include :car_id (e.g., /api/v1/users/45/cars/1/maintenance_records)
        car = current_user.cars.find(params[:car_id])
        maintenance_record = car.maintenance_records.build(maintenance_record_params)
        if maintenance_record.save
          render json: maintenance_record, status: :created
        else
          render json: { errors: maintenance_record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private
      def maintenance_record_params
        params.require(:maintenance_record).permit(:service_date, :service_type, :cost, :notes)
      end
    end
  end
end
