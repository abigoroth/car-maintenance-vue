module Api
  module V1
    class MaintenanceSchedulesController < ApiController
      def index
        render json: current_user.maintenance_schedules.with_part.history(params[:show_history]).to_json(include: :part)
      end

      def destroy
        maintenance_schedule = current_user.maintenance_schedules.find(params[:id])
        maintenance_schedule.destroy
        head :ok
      end
    end
  end
end
