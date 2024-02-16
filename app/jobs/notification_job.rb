# frozen_string_literal: true

class NotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    if args[:maintenance_schedule]
      maintenance_schedule = MaintenanceSchedule.find(args[:maintenance_schedule])
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

    api_instance = OneSignal::DefaultApi.new
    notification = OneSignal::Notification.new({app_id: 'df76982b-a7a9-4ebb-8a79-7d9b722f8d95'})
    notification.contents = OneSignal::StringMap.new({ en: 'hello'})
    notification.included_segments = [maintenance_schedule.user.os_id]

    begin
      # Create notification
      result = api_instance.create_notification(notification)
      p result
    rescue OneSignal::ApiError => e
      puts "Error when calling DefaultApi->create_notification: #{e}"
    end
  end
end
