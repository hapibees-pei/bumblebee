class CreateApiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :apiaries, id: :uuid do |t|
      t.string :location
      t.belongs_to :user, index: true, type: :uuid

      t.timestamps
    end
  end
end
