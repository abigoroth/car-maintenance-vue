class CreateWorkshops < ActiveRecord::Migration[7.0]
  def change
    create_table :workshops do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :business
      t.string :location
      t.string :rating

      t.timestamps
    end
  end
end
