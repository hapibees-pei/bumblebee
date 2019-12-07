class PortApiary < ActiveRecord::Migration[6.0]
  def change
    change_table :apiaries do |t|
      t.remove :port
      t.integer :port, null: false
    end
  end
end
