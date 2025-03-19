class Api::V1::CarsController < Api::V1::BaseController
  before_action :authenticate_user!

  def index
    @cars = current_user.cars
    render json: @cars
  end

  def create
    @car = current_user.cars.build(car_params)
    if @car.save
      render json: @car, status: :created
    else
      render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def car_params
    params.require(:car).permit(:make, :model, :year, :oil_change_interval, :odometer, :last_oil_change)
  end
end
