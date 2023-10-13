module Api::V1
  class VehiclesController < ApiController
    def create
      vehicle = Vehicle.new(vehicle_params)
      if vehicle.save
        render json: vehicle
      else
        render json: { errors: vehicle.errors.full_messages }, status: 422
      end
    end

    def index
      render json: Vehicle.all
    end

    def vehicle_params
      params.permit(:make, :model, :year, :vin_number, :mileage, :plate_number)
    end

  end

end
