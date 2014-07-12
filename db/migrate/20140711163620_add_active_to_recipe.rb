class AddActiveToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :is_active, :boolean, default: true
  end
end
