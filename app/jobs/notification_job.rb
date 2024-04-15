# frozen_string_literal: true

class NotificationJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(maintenance_schedule_id: nil)
    if maintenance_schedule_id.present?
      maintenance_schedule = MaintenanceSchedule.find(maintenance_schedule_id)
      notify_owner(maintenance_schedule)
    else
      # query for today notification and send it
      MaintenanceSchedule.need_notify.each do |maintenance_schedule|
        notify_owner(maintenance_schedule)
      end
    end
  end

  def notify_owner(maintenance_schedule)
    return unless maintenance_schedule.user.os_id

    party_return = HTTParty.post('https://onesignal.com/api/v1/notifications', body: {
      app_id: 'fa7fecdd-07eb-42c7-845c-48798f1b332d',
      include_aliases: {
        external_id: ["#{maintenance_schedule.user_id}"]
      },
      target_channel: 'push',
      contents: {en: "#{maintenance_schedule.part.name} #{maintenance_schedule.vehicle.plate_number}"},
      url: "https://app.sevoti.com/panel/vehicles/#{maintenance_schedule.vehicle_id}/maintenance_schedules/#{maintenance_schedule.id}",
      buttons: [{id: 'see-details', text: 'See details', url: "https://app.sevoti.com/panel/vehicles/#{maintenance_schedule.vehicle_id}/maintenance_schedules/#{maintenance_schedule.id}"}],
    }.to_json, headers: {
      'Content-Type' => 'application/json',
      'Authorization' => "Basic #{OneSignal.configure.app_key}"
    })
    maintenance_schedule.update_columns(
      notified: Date.today,
      os_return: party_return.to_json
    )
  end
end
