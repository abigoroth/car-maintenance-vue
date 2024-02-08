# == Schema Information
#
# Table name: maintenance_schedules
#
#  id             :bigint           not null, primary key
#  part_id        :integer
#  date           :datetime
#  status         :integer
#  note           :string
#  target_mileage :integer
#  workshop_id    :integer
#  vehicle_id     :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_maintenance_schedules_on_vehicle_id  (vehicle_id)
#
class MaintenanceSchedule < ApplicationRecord
  belongs_to :vehicle
  belongs_to :part
  belongs_to :user

  scope :with_part, -> { includes(:part) }
  scope :history, lambda { |show_history|
    (show_history == 'true' ? where(status: :completed) : where.not(status: :completed))
  }
  enum :status, { completed: 0, created: 1, overdue: 2, delayed: 3 }, _prefix: :ms

  def date
    attributes['date'].strftime('%d / %m / %Y')
  end

  def send_whatsapp_reminder
    require 'uri'
    require 'json'
    require 'net/http'

    url = URI('https://j36454.api.infobip.com/whatsapp/1/message/template')

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Authorization'] = 'App 080399e925c5d15b7bb6ba4f8900e755-3d9fb96d-3c6e-4a45-883b-d9ed4a650487'
    request['Content-Type'] = 'application/json'
    request['Accept'] = 'application/json'
    request.body = JSON.dump({
                               "messages": [
                                 {
                                   "from": '447860099299',
                                   "to": '60172931521',
                                   "messageId": 'db16d5a9-0e66-499d-bf66-5ec21b6c13b7',
                                   "content": {
                                     "templateName": 'message_test',
                                     "templateData": {
                                       "body": {
                                         "placeholders": ['yakob']
                                       }
                                     },
                                     "language": 'en'
                                   }
                                 }
                               ]
                             })

    response = https.request(request)
    puts response.read_body
  end
end
