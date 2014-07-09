class CreateRecipeEntries < ActiveRecord::Migration
  def change
    create_table :recipe_entries do |t|
      t.decimal :quantity
      t.references :recipe, index: true
      t.references :ingredient, index: true

      t.timestamps
    end
  end
end
