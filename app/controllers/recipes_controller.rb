class RecipesController < ApplicationController

  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes.order(:name)
  end

end
