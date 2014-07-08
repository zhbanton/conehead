class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :note
      t.references :user

      t.timestamps
    end
  end
end
