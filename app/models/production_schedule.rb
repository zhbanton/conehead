class ProductionSchedule < ActiveRecord::Base

  GRAMS_PER_POUND = 453.592

  has_many :entries, as: :document, dependent: :destroy
  has_many :recipes, through: :entries
  belongs_to :user

  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true


  validates :entries, presence: true
  validates :starting_date, presence: true, date: { on_or_after: Day.all.first.date }
  validates :ending_date, presence: true, date: { on_or_after: :starting_date }

  def list_required_ingredients
    required_ingredients = {}
    entries.each do |entry|
      recipe_to_size = entry.recipe.to_batch_size
      recipe_to_size.recipe_entries.each do |recipe_entry|
        if required_ingredients[recipe_entry.ingredient.name]
          required_ingredients[recipe_entry.ingredient.name] += (entry.quantity * recipe_entry.quantity) / GRAMS_PER_POUND
        else
          required_ingredients[recipe_entry.ingredient.name] = (entry.quantity * recipe_entry.quantity) /GRAMS_PER_POUND
        end
      end
    end
    required_ingredients
  end

  def total_output
    (entries.map { |entry| entry.quantity * User::BATCH_SIZE }.reduce(:+)) / GRAMS_PER_POUND
  end

  def to_s
    "#{starting_date.to_formatted_s(:long_ordinal)} - #{ending_date.to_formatted_s(:long_ordinal)}"
  end

end
