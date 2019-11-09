class CreateApiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :apiaries, id: :uuid do |t|
      t.uuid :gateway_id
      t.string :location
      t.belongs_to :user, index: true, type: :uuid

      t.timestamps
    end

    add_index :apiaries, :gateway_id, unique: true
  end
end
