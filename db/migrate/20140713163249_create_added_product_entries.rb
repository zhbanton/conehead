class CreateAddedProductEntries < ActiveRecord::Migration
  def change
    create_table :added_product_entries do |t|
      t.integer :quantity
      t.references :recipe, index: true
      t.references :added_product, index: true

      t.timestamps
    end
  end
end
