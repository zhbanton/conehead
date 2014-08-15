class RemoveJoinTables < ActiveRecord::Migration

  def up
    drop_table :ending_inventory_entries
    drop_table :starting_inventory_entries
    drop_table :added_inventory_entries
    drop_table :production_schedule_entries
  end

  def down
    create_table :ending_inventory_entries do |t|
      t.decimal :quantity
      t.references :ending_inventory, index: true
      t.references :recipe, index: true

      t.timestamps
    end

    create_table :starting_inventory_entries do |t|
      t.decimal :quantity
      t.references :starting_inventory, index: true
      t.references :recipe, index: true

      t.timestamps
    end

    create_table :added_inventory_entries do |t|
      t.decimal :quantity
      t.references :added_inventory, index: true
      t.references :recipe, index: true

      t.timestamps
    end

    create_table :production_schedule_entries do |t|
      t.decimal :quantity
      t.references :production_schedule, index: true
      t.references :recipe, index: true

      t.timestamps
    end
  end

end
