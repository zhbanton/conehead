class ProductionScheduleEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :production_schedule

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
