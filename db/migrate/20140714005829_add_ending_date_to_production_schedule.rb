class AddEndingDateToProductionSchedule < ActiveRecord::Migration
  def change
    add_column :production_schedules, :ending_date, :date
  end
end
