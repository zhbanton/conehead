class DaysController < ApplicationController

  before_action :authenticate_user!

  def show
    @day = Day.find(params[:id])
    @starting_inventory= @day.starting_inventory(current_user)
    @added_inventory= @day.added_inventory(current_user)
    @ending_inventory= @day.ending_inventory(current_user)
    @net_sales_by_product = @day.net_sales_by_product(current_user)
    @net_sales = @day.net_sales(current_user)
    @production_schedules = @day.production_schedules(current_user)
  end

end
