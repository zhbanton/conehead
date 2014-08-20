class AddedInventoriesController < ApplicationController
  before_action :set_recipe_select, only: [:new, :edit, :create, :update]
  before_action :set_day
  before_action :set_added_inventory, only: [:edit, :update]

  def new
    @added_inventory = current_user.added_inventories.new
  end

  def create
    @added_inventory = current_user.added_inventories.new(added_inventory_params)
    if @added_inventory.save
      redirect_to day_path(@day), notice: "Inventory added for #{@added_inventory.inventory_date.to_formatted_s(:long_ordinal)} created"
    else
      flash.now[:alert] = @added_inventory.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @added_inventory.update(added_inventory_params)
      redirect_to day_path(@day), notice: "Inventory added for #{@added_inventory.inventory_date.to_formatted_s(:long_ordinal)} updated"
    else
      flash.now[:alert] = @added_inventory.errors.full_messages.join(', ')
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

  def set_added_inventory
    @added_inventory = AddedInventory.find(params[:id])
  end

  def added_inventory_params
    params.require(:added_inventory).permit(:inventory_date, added_inventory_entries_attributes: [:id, :quantity, :added_inventory_id, :recipe_id, :_destroy])
  end

end
