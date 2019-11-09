class UserAttrs < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :name
      t.text :address
    end
  end
end
