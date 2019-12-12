class ChangeSensorIdToBeIntegerInHives < ActiveRecord::Migration[6.0]
  def change
    remove_column :hives, :sensor_id
    add_column :hives, :sensor_id, :integer
  end
end
