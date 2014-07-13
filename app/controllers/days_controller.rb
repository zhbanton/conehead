class DaysController < ApplicationController

before_action :authenticate_user!

  def index
    @days = Day.all
  end

  def show
    @day = Day.find(params[:id])
    @starting_inventories = current_user.starting_inventories.where(inventory_date: @day.date)
  end

  def weeks
  end

end
