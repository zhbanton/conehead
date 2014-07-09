class AddUserAssociationToIngredients < ActiveRecord::Migration
  def change
    change_table :ingredients do |t|
      t.references :user, index: true
    end
  end
end
