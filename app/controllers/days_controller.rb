class DaysController < ApplicationController

before_action :authenticate_user!

  def index
    @days = Day.all
  end

  def show
    @day = Day.find(params[:id])
    @starting_inventory= @day.starting_inventory(current_user)
    @ending_inventory= @day.ending_inventory(current_user)
    @net_sales = @day.net_sales(current_user)
  end

  def weeks
  end

end
