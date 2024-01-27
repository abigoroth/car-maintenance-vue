module Api::V1
  class MaintenanceSchedulesController < ApiController
    def index
      render json: vehicle.maintenance_schedules.with_part.to_json(include: :part)
    end
    def create
      maintenance_schedule = MaintenanceSchedule.new(maintenance_schedule_params)
      if maintenance_schedule.save
        render json: maintenance_schedule
      else
        render json: { errors: maintenance_schedule.errors.full_messages }, status: 422
      end
    end

    def vehicle
      Vehicle.find(params[:vehicle_id])
    end

    def destroy
      maintenance_schedule = MaintenanceSchedule.find(params[:id])
      maintenance_schedule.destroy
      head :ok
    end

    def maintenance_schedule_params
      params.permit(:part_id, :date, :status, :note, :target_mileage, :workshop_id, :vehicle_id)
    end
  end
end
