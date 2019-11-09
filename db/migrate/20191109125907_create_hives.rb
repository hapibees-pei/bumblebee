class CreateHives < ActiveRecord::Migration[6.0]
  def change
    create_table :hives, id: :uuid do |t|
      t.string :name, default: ""
      t.text :description
      t.integer :bee_number
      t.uuid :sensor_id
      t.integer :status, default: 0
      t.integer :success_rate, default: 0
      t.belongs_to :apiary, index: true, type: :uuid

      t.timestamps
    end
  end
end
