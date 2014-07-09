class CreateProductionScheduleEntries < ActiveRecord::Migration
  def change
    create_table :production_schedule_entries do |t|
      t.decimal :batch_quantity
      t.references :production_schedule, index: true
      t.references :recipe, index: true

      t.timestamps
    end
  end
end
