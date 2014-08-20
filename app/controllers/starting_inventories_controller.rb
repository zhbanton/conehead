class StartingInventoriesController < ApplicationController
  before_action :set_recipe_select, only: [:new, :edit, :create, :update]
  before_action :set_day
  before_action :set_starting_inventory, only: [:edit, :update]

  def new
    @starting_inventory = current_user.starting_inventories.new
  end

  def create
    @starting_inventory = current_user.starting_inventories.new(starting_inventory_params)
    if @starting_inventory.save
      redirect_to day_path(@day), notice: "Beginning of day inventory for #{@starting_inventory.inventory_date.to_formatted_s(:long_ordinal)} created"
    else
      flash.now[:alert] = @starting_inventory.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @starting_inventory.update(starting_inventory_params)
      redirect_to day_path(@day), notice: "Beginning of day inventory for #{@starting_inventory.inventory_date.to_formatted_s(:long_ordinal)} updated"
    else
      flash.now[:alert] = @starting_inventory.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def set_recipe_select
    @recipe_select = current_user.recipes.where(is_active: true).map { |r| [r.name,r.id] }
  end

  def set_day
    @day = Day.find(params[:day_id])
  end

  def set_starting_inventory
    @starting_inventory = StartingInventory.find(params[:id])
  end

  def starting_inventory_params
    params.require(:starting_inventory).permit(:inventory_date, :employee, starting_inventory_entries_attributes: [:id, :quantity, :starting_inventory_id, :recipe_id, :_destroy])
  end

end
