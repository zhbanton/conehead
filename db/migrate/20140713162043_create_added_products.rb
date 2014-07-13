class CreateAddedProducts < ActiveRecord::Migration
  def change
    create_table :added_products do |t|
      t.references :user, index: true
      t.date :inventory_date

      t.timestamps
    end
  end
end
