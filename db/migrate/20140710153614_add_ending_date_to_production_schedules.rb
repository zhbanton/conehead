class AddEndingDateToProductionSchedules < ActiveRecord::Migration
  def change
    rename_column :production_schedules, :production_date, :starting_date
    add_column :production_schedules, :ending_date, :date
  end
end
