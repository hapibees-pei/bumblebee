class AddGatewayValues < ActiveRecord::Migration[6.0]
  def change
    change_table :apiaries do |t|
      t.string :ip, null: false, default: ""
      t.string :port, null: false, default: ""
    end
  end
end
