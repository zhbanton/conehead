class RecipesController < ApplicationController

  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes.order(:name)
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.save!

    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :note, :user_id, recipe_entries_attributes: [:id, :quantity, :recipe_id, :ingredient_id, ingredient_attributes: [:id, :name, :user_id]])
  end

end
