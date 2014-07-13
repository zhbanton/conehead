class EndingInventoriesController < ApplicationController
  before_action :set_recipe_select, only: [:new, :edit, :create, :update]
  before_action :set_day
  before_action :set_ending_inventory, only: [:edit, :update]

  def new
    @ending_inventory = current_user.ending_inventories.new
    starting_inventory = current_user.starting_inventories.where(inventory_date: @day.date).first
    added_inventory = current_user.added_inventories.where(inventory_date: @day.date).first
    @ending_inventory.set_to_days_inventory(starting_inventory, added_inventory) if starting_inventory.present?
  end

  def create
    @ending_inventory = current_user.ending_inventories.new(ending_inventory_params)
    if @ending_inventory.save
      redirect_to day_path(@day), notice: "End of day inventory for #{@ending_inventory.inventory_date.to_formatted_s(:long_ordinal)} created"
    else
      flash.now[:alert] = @ending_inventory.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @ending_inventory.update(ending_inventory_params)
      redirect_to day_path(@day), notice: "End of day inventory for #{@ending_inventory.inventory_date.to_formatted_s(:long_ordinal)} updated"
    else
      flash.now[:alert] = @ending_inventory.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def set_recipe_select
    @recipe_select = Recipe.where(is_active: true).map { |r| [r.name,r.id] }
  end

  def set_day
    @day = Day.find(params[:day_id])
  end

  def set_ending_inventory
    @ending_inventory = EndingInventory.find(params[:id])
  end

  def ending_inventory_params
    params.require(:ending_inventory).permit(:inventory_date, :employee, ending_inventory_entries_attributes: [:id, :quantity, :ending_inventory_id, :recipe_id, :_destroy])
  end

end
