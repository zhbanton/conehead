class EndingInventoryEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ending_inventory

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :recipe_id, presence: true

  def one_production_scheudle_per_week
    found_error = false
    ProductionSchedule.all.each do |schedule|
      if starting_date.present? && starting_date.cweek == schedule.starting_date.cweek && starting_date.year == schedule.starting_date.year && user_id == schedule.user_id
        found_error = true
      end
    end
    if found_error
      errors.add(:starting_date, "schedule already exists for that week")
    end
  end
end

