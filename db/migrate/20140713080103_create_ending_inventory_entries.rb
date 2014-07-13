class CreateEndingInventoryEntries < ActiveRecord::Migration
  def change
    create_table :ending_inventory_entries do |t|
      t.references :recipe, index: true
      t.references :ending_inventory, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
