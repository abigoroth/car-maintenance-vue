class RenameTargetMileageToMileageFromMaintenanceSchedules < ActiveRecord::Migration[7.0]
  def change
    rename_column :maintenance_schedules, :target_mileage, :mileage
  end
end
