class MaintenanceRecordsController < ApplicationController
before_action :set_car, only: %i[show edit update destroy]
def index
  @maintenance_records = current_user.maintenance_records
end


def show
  @car = Car.find(params[:car_id])
  @maintenance_record = @car.maintenance_records.find(params[:id]) # Ensure the ID is being retrieved correctly
end

def new
  @car = Car.find(params[:car_id])
  @maintenance_record = @car.maintenance_records.build
end

def create
  @car = Car.find(params[:car_id])
  @maintenance_record = @car.maintenance_records.build(maintenance_record_params)


  if @maintenance_record.save
    redirect_to user_car_path(current_user, @car), notice: "Maintenance record created successfully."
  else
    render :new, alert: "Failed to create maintenance record."
  end
end

def edit
  @maintenance_record = @car.maintenance_records.find(params[:id])  # Ensure you're fetching the record
end

def update
  @car = Car.find_by(id: params[:car_id])
  @maintenance_record = @car&.maintenance_records.find_by(id: params[:id])


  if @maintenance_record.update(maintenance_record_params)
    redirect_to user_car_path(current_user, @car), notice: "Record updated successfully."
  else
    render :edit, alert: "Failed to update record."
  end
end

def destroy
  @car = Car.find_by(id: params[:car_id])
  @maintenance_record = @car.maintenance_records.find(params[:id])
  @maintenance_record.destroy!
  respond_to do |format|
    format.html { redirect_to user_car_maintenance_record_path(current_user), status: :see_other, alert: "Record was successfully deleted.", flash: { alert_type: "danger" } }
    format.json { head :no_content }
  end
end


private

def maintenance_record_params
  params.require(:maintenance_record).permit(:service_date, :service_type, :cost, :notes)
end


def set_car
  @car = current_user.cars.find_by(id: params[:car_id])
  redirect_to user_cars_path(current_user), alert: "Car not found." if @car.nil?
end
end
