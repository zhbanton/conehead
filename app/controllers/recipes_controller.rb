class RecipesController < ApplicationController

  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes.order(:name)
  end

  def show
    @recipe = recipe(params[:id])
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe Created'
    else
      flash.now[:alert] = @recipe.errors.full_messages.join(', ')
      render :new
    end


  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :note, :user_id, recipe_entries_attributes: [:id, :quantity, :recipe_id, :ingredient_id, ingredient_attributes: [:id, :name, :user_id]])
  end

end
