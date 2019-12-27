class AddNameToApiary < ActiveRecord::Migration[6.0]
  def change
    change_table :apiaries do |t|
      t.string :name, null: false, default: ""
    end
  end
end
