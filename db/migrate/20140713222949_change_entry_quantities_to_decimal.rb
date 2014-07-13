class ChangeEntryQuantitiesToDecimal < ActiveRecord::Migration
  def change
    change_column :starting_inventory_entries, :quantity, :decimal
    change_column :added_inventory_entries, :quantity, :decimal
    change_column :ending_inventory_entries, :quantity, :decimal
  end
end
