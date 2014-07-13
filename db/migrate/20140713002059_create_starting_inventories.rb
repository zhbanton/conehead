class CreateStartingInventories < ActiveRecord::Migration
  def change
    create_table :starting_inventories do |t|
      t.date :inventory_date
      t.string :employee

      t.timestamps
    end
  end
end
