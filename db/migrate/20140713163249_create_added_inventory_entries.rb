class CreateAddedInventoryEntries < ActiveRecord::Migration
  def change
    create_table :added_inventory_entries do |t|
      t.integer :quantity
      t.references :recipe, index: true
      t.references :added_inventory, index: true

      t.timestamps
    end
  end
end
