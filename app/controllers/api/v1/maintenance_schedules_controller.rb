module Api
  module V1
    class MaintenanceSchedulesController < ApiController
      before_action :set_maintenance_schedule, only: %i[update]
      def index
        @maintenance_schedules = current_user.maintenance_schedules.with_part_and_vehicle.history(params[:show_history])
        render 'api/v1/vehicles/maintenance_schedules/index'
      end

      def update
        if @maintenance_schedule.update(maintenance_schedule_params)
          head :ok
        else
          render json: @maintenance_schedule, status: :bad_request
        end
      end

      def set_maintenance_schedule
        @maintenance_schedule = MaintenanceSchedule.find(params[:id])
      end

      def destroy
        maintenance_schedule = current_user.maintenance_schedules.find(params[:id])
        maintenance_schedule.destroy
        head :ok
      end

      def maintenance_schedule_params
        params.permit(:status, :part_id, :date, :status, :note, :mileage, :price, :workshop_id, :price)
      end
    end
  end
end
