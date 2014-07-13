class CreateEndingInventories < ActiveRecord::Migration
  def change
    create_table :ending_inventories do |t|
      t.references :user, index: true
      t.string :employee
      t.date :inventory_date

      t.timestamps
    end
  end
end
