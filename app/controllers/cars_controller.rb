class CarsController < ApplicationController
  before_action :require_login, only: %i[index new create edit update destroy]
  before_action :set_car, only: %i[show edit update destroy]

  def index
    @cars = current_user.cars
  end

  def show
  end

  # %=
  def new
    @car = current_user.cars.build
  end

  def edit
  end

  def create
    @car = current_user.cars.build(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to user_car_path(current_user, @car), notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to user_car_path(current_user, @car), notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @car.destroy!
    respond_to do |format|
      format.html { redirect_to user_cars_path(current_user), status: :see_other, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def require_login
    redirect_to new_session_path, alert: "Please log in first." unless current_user
  end

  def set_car
    Rails.logger.debug "Current User: #{current_user.id}"
    Rails.logger.debug "Requested Car ID: #{params[:id]}"
    Rails.logger.debug "Requested User ID: #{params[:user_id]}"
    @car = current_user.cars.find_by(id: params[:id])
    Rails.logger.debug "Found Car: #{@car.inspect}"
    redirect_to user_cars_path(current_user), alert: "Car not found." unless @car
  end

  def car_params
    params.require(:car).permit(:make, :model, :year)
  end
end
