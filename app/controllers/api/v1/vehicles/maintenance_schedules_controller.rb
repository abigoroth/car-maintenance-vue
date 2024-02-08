# frozen_string_literal: true

module Api
  module V1
    module Vehicles
      class MaintenanceSchedulesController < ApiController
        before_action :set_maintenance_schedule, only: %i[send_whatsapp_notification destroy]
        def index
          render json: vehicle.maintenance_schedules.with_part.history(params[:show_history]).to_json(include: :part)
        end
        def create
          maintenance_schedule = MaintenanceSchedule.new(maintenance_schedule_params.merge(user_id: current_user.id))
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
          @maintenance_schedule.destroy
          head :ok
        end

        def set_maintenance_schedule
          @maintenance_schedule = MaintenanceSchedule.find(params[:id])
        end

        def maintenance_schedule_params
          params.permit(:part_id, :date, :status, :note, :target_mileage, :workshop_id, :vehicle_id)
        end
      end
    end
  end
end
