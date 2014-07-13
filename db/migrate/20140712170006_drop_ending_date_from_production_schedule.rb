class DropEndingDateFromProductionSchedule < ActiveRecord::Migration
  def up
    change_table :production_schedules do |t|
      t.remove :ending_date
    end
  end

  def down
    change_table :production_schedules do |t|
      t.date :ending_date
    end
  end
end
