module Api::V1
  class MaintenanceSchedulesController < ApiController
    def index
      render json: MaintenanceSchedule.all
    end
    def create
      maintenance_schedule = MaintenanceSchedule.new(maintenance_schedule_params)
      if maintenance_schedule.save
        render json: maintenance_schedule
      else
        render json: { errors: maintenance_schedule.errors.full_messages }, status: 422
      end
    end

    def show

    end

    def maintenance_schedule_params
      params.permit(:part_id, :date, :status, :note, :target_mileage, :workshop_id)
    end
  end
end
