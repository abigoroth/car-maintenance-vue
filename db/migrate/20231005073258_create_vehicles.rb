class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.string :vin_number
      t.integer :mileage
      t.integer :user_id
      t.string :plate_number

      t.timestamps
    end
  end
end
