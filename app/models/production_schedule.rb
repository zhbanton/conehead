class ProductionSchedule < ActiveRecord::Base

  has_many :production_schedule_entries, dependent: :destroy
  has_many :recipes, through: :production_schedule_entries
  belongs_to :user

  accepts_nested_attributes_for :production_schedule_entries, reject_if: :all_blank

  validates :production_schedule_entries, presence: true
  validates :starting_date, presence: true, date: { on_or_after: Date.today }
  validate :one_production_scheudle_per_week

  def list_required_ingredients
    required_ingredients = {}
    production_schedule_entries.each do |production_schedule_entry|
      recipe_to_size = production_schedule_entry.recipe.to_batch_size
      recipe_to_size.recipe_entries.each do |recipe_entry|
        if required_ingredients[recipe_entry.ingredient.name]
          required_ingredients[recipe_entry.ingredient.name] += production_schedule_entry.quantity * recipe_entry.quantity
        else
          required_ingredients[recipe_entry.ingredient.name] = production_schedule_entry.quantity * recipe_entry.quantity
        end
      end
    end
    required_ingredients
  end

  def total_output
    production_schedule_entries.map { |entry| entry.quantity * User::BATCH_SIZE }.reduce(:+)
  end

  private

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
