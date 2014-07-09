class CreateProductionSchedules < ActiveRecord::Migration
  def change
    create_table :production_schedules do |t|
      t.date :production_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
