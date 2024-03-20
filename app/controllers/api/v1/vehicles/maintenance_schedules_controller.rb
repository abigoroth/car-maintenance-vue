# frozen_string_literal: true

module Api
  module V1
    module Vehicles
      class MaintenanceSchedulesController < ApiController
        before_action :set_maintenance_schedule, only: %i[send_notification destroy show]
        def index
          render json: vehicle.maintenance_schedules.with_part.history(params[:show_history]).to_json(include: %i[part vehicle])
        end

        def show
          render json: @maintenance_schedule.to_json(include: [:part, :vehicle])
        end

        def create
          maintenance_schedule = MaintenanceSchedule.new(maintenance_schedule_params.merge(user_id: current_user.id))
          if maintenance_schedule.save
            render json: maintenance_schedule
          else
            render json: { errors: maintenance_schedule.errors.full_messages }, status: 422
          end
        end

        def send_notification
          NotificationJob.perform_later(maintenance_schedule_id: @maintenance_schedule.id)
        end

        def vehicle
          Vehicle.find(params[:vehicle_id])
        end

        def destroy
          if @maintenance_schedule.destroy
            head :ok
          else
            render json: @maintenance_schedule.errors, status: :bad_request
          end
        end

        def set_maintenance_schedule
          @maintenance_schedule = MaintenanceSchedule.eager_load(:vehicle, :part).find(params[:id] || params[:maintenance_schedule_id])
        end

        def maintenance_schedule_params
          params.permit(:part_id, :date, :status, :note, :mileage, :workshop_id, :vehicle_id, :price)
        end
      end
    end
  end
end
