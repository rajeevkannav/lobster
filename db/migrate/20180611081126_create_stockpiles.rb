class CreateStockpiles < ActiveRecord::Migration[5.2]
  def change
    create_table :stockpiles do |t|
      t.references :product
      t.references :warehouse

      t.integer :stock_on_hand, default: 0
      t.integer :stock_on_reserve, default: 0
      t.timestamps
    end
  end
end
