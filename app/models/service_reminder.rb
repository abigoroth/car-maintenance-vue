# == Schema Information
#
# Table name: service_reminders
#
#  id           :bigint           not null, primary key
#  description  :string
#  completed    :boolean
#  service_date :date
#  vehicle_id   :bigint
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_service_reminders_on_vehicle_id  (vehicle_id)
#
class ServiceReminder < ApplicationRecord
end
