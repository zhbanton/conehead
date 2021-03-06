class CreateStartingInventoryEntries < ActiveRecord::Migration
  def change
    create_table :starting_inventory_entries do |t|
      t.references :recipe, index: true
      t.references :starting_inventory, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
