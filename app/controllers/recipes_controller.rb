class RecipesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = current_user.recipes.where(is_active: true).order(:name)
  end

  def new
    @recipe = current_user.recipes.new
  end

  def show
    @recipe = @recipe.to_batch_size
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: "Recipe for #{@recipe.name} created"
    else
      flash.now[:alert] = @recipe.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @recipe.update(recipe_params)
      if @recipe.is_active
        redirect_to recipes_path, notice: "Recipe for #{@recipe.name} updated"
      else
        redirect_to recipes_path, notice: "Recipe for #{@recipe.name} deleted"
      end
    else
      flash.now[:alert] = @recipe.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :note, :is_active, :user_id, recipe_entries_attributes: [:id, :quantity, :recipe_id, :ingredient_id, ingredient_attributes: [:id, :name, :user_id]])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

end
