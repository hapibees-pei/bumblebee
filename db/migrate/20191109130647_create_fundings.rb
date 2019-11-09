class CreateFundings < ActiveRecord::Migration[6.0]
  def change
    create_table :fundings, id: :uuid do |t|
      t.integer :status, default: 0
      t.monetize :price
      t.belongs_to :hive, index: true, type: :uuid
      t.belongs_to :user, index: true, type: :uuid

      t.timestamps
    end
  end
end
