module Api::V1
  class VehiclesController < ApiController
    def create
      vehicle = current_user.vehicles.new(vehicle_params)
      if vehicle.save
        render json: vehicle
      else
        render json: { errors: vehicle.errors.full_messages }, status: 422
      end
    end

    def destroy
      @vehicle = Vehicle.find(params[:id])
      @vehicle.destroy
      head :ok
    end

    def index
      render json: current_user.vehicles
    end

    def show
      render json: Vehicle.find(params[:id])
    end

    def vehicle_params
      params.permit(:make, :model, :year, :vin_number, :mileage, :plate_number)
    end

  end

end
