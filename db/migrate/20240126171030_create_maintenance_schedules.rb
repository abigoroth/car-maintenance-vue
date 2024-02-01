class CreateMaintenanceSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :maintenance_schedules do |t|
      t.integer :part_id
      t.datetime :date
      t.integer :status
      t.string :note
      t.integer :target_mileage
      t.integer :workshop_id
      t.belongs_to :vehicle

      t.timestamps
    end
  end
end
