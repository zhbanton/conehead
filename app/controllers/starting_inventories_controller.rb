class StartingInventoriesController < ApplicationController
  before_action :set_recipe_select, only: [:new, :edit, :create]

  def new
    @starting_inventory = current_user.starting_inventories.new
    @day = params[:day]
  end

  def create
    @starting_inventory = current_user.starting_inventories.new(starting_inventory_params)
    if @starting_inventory.save
      redirect_to view_day_days_path(day: @starting_inventory.inventory_date), notice: "Starting Inventory for #{@starting_inventory.inventory_date.to_formatted_s(:long_ordinal)} created"
    else
      flash.now[:alert] = @starting_inventory.errors.full_messages.join(', ')
      render "starting_inventories/new", locals: { day: @starting_inventory.inventory_date }
    end
  end

  private

  def set_recipe_select
    @recipe_select = Recipe.where(is_active: true).map { |r| [r.name,r.id] }
  end

  def starting_inventory_params
    params.require(:starting_inventory).permit(:inventory_date, :employee, starting_inventory_entries_attributes: [:id, :quantity, :starting_inventory_id, :recipe_id])
  end

end
