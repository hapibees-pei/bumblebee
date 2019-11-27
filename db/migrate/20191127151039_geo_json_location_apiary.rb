class GeoJsonLocationApiary < ActiveRecord::Migration[6.0]
  def change
    change_table :apiaries do |t|
      t.remove :location
      t.jsonb :location, null: false, default: '{}'
    end
  end
end
