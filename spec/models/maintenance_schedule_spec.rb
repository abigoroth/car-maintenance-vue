# == Schema Information
#
# Table name: maintenance_schedules
#
#  id          :bigint           not null, primary key
#  part_id     :integer
#  date        :datetime
#  status      :integer
#  note        :string
#  mileage     :integer
#  workshop_id :integer
#  vehicle_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  price       :integer          default(0)
#  notified    :date
#  os_return   :text
#
# Indexes
#
#  index_maintenance_schedules_on_vehicle_id  (vehicle_id)
#
require 'rails_helper'

RSpec.describe MaintenanceSchedule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
