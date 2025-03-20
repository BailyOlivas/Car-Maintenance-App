class MaintenanceRecordsController < ApplicationController
before_action :set_car, only: %i[show edit update destroy]
def index
  @maintenance_records = current_user.maintenance_records

  respond_to do |format|
    format.html
    format.json { render json: @logs }
  end
end


def show
  @car = Car.find(params[:car_id])
  @maintenance_record = @car.maintenance_records.find(params[:id]) # Ensure the ID is being retrieved correctly

  respond_to do |format|
    format.html
    format.json { render json: @log }
  end
end

def new
  @car = Car.find(params[:car_id])
  @maintenance_record = @car.maintenance_records.build
end

def create
  @car = Car.find(params[:car_id])
  @maintenance_record = @car.maintenance_records.build(maintenance_record_params)

  respond_to do |format|
    if @maintenance_record.save
      format.html { redirect_to user_car_path(current_user, @car), notice: "Maintenance record created successfully." }
      format.json { render json: @maintenance_record, status: :created }
    else
      flash[:alert] = "Failed to create maintenance record."  # Proper way to show flash message
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity }
    end
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
  params.require(:maintenance_record).permit(:service_date, :service_type, :cost, :notes, :miles)
end


def set_car
  @car = current_user.cars.find_by(id: params[:car_id])
  redirect_to user_cars_path(current_user), alert: "Car not found." if @car.nil?
end
end
