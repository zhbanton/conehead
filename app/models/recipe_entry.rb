class RecipeEntry < ActiveRecord::Base

  belongs_to :ingredient
  belongs_to :recipe

  accepts_nested_attributes_for :ingredient, reject_if: proc { |attributes| attributes['name'].blank? }

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :ingredient_id, presence: true

  def ingredient_attributes=(ingredient_attributes)
    ingredient = Ingredient.find_or_create_by(name: ingredient_attributes[:name].downcase, user_id: ingredient_attributes[:user_id])
    self.ingredient_id = ingredient.id
  end

end
