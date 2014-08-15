class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.decimal :quantity
      t.references :document, polymorphic: true, index: true
      t.references :recipe, index: true

      t.timestamps
    end
  end
end
