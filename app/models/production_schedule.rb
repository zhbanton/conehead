class ProductionSchedule < ActiveRecord::Base
  has_many :production_schedule_entries, dependent: :destroy
  has_many :recipes, through: :production_schedule_entries

  accepts_nested_attributes_for :production_schedule_entries, reject_if: :all_blank

  validates :production_schedule_entries, presence: true

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
end
