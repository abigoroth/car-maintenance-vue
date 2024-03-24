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
#
# Indexes
#
#  index_maintenance_schedules_on_vehicle_id  (vehicle_id)
#
class MaintenanceSchedule < ApplicationRecord
  belongs_to :vehicle
  belongs_to :part
  belongs_to :user

  include ActionView::Helpers::NumberHelper

  scope :with_part_and_vehicle, -> { eager_load(:part, :vehicle) }
  scope :history, lambda { |show_history|
    (show_history == 'true' ? where(status: :completed) : where.not(status: :completed))
  }
  scope :need_notify, -> { where(status: [:created, :overdue]) }
  # overdue is when it passes the date but its on snooze
  enum :status, { completed: 0, created: 1, overdue: 2, delayed: 3 }, _prefix: :ms

  def date
    attributes['date']&.strftime('%d / %m / %Y')
  end

  def mileage
    number_with_delimiter(attributes['mileage'])
  end

end
