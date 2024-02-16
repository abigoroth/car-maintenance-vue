class AddOsIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :os_id, :string
  end
end
