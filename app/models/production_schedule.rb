class ProductionSchedule < ActiveRecord::Base

  GRAMS_PER_POUND = 453.592

  has_many :production_schedule_entries, dependent: :destroy
  has_many :recipes, through: :production_schedule_entries
  belongs_to :user

  accepts_nested_attributes_for :production_schedule_entries, reject_if: :all_blank, allow_destroy: true

  validates :production_schedule_entries, presence: true
  validates :starting_date, presence: true, date: { on_or_after: Day.all.first.date }
  validates :ending_date, presence: true, date: { on_or_after: :starting_date }

  def list_required_ingredients
    required_ingredients = {}
    production_schedule_entries.each do |production_schedule_entry|
      recipe_to_size = production_schedule_entry.recipe.to_batch_size
      recipe_to_size.recipe_entries.each do |recipe_entry|
        if required_ingredients[recipe_entry.ingredient.name]
          required_ingredients[recipe_entry.ingredient.name] += (production_schedule_entry.quantity * recipe_entry.quantity) / GRAMS_PER_POUND
        else
          required_ingredients[recipe_entry.ingredient.name] = (production_schedule_entry.quantity * recipe_entry.quantity) /GRAMS_PER_POUND
        end
      end
    end
    required_ingredients
  end

  def total_output
    (production_schedule_entries.map { |entry| entry.quantity * User::BATCH_SIZE }.reduce(:+)) / GRAMS_PER_POUND
  end

  def to_s
    "#{starting_date.to_formatted_s(:long_ordinal)} - #{ending_date.to_formatted_s(:long_ordinal)}"
  end

end
