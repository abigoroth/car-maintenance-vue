class AddUserIdToMaintenanceSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :maintenance_schedules, :user_id, :integer
  end
end
