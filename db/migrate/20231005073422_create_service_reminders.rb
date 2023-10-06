class CreateServiceReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_reminders do |t|
      t.string :description
      t.boolean :completed
      t.date :service_date
      t.references :vehicle, foreign_key: true
      t.integer :user_id
      t.timestamps
    end
  end
end
