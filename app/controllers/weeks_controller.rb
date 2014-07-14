class WeeksController < ApplicationController

  before_action :authenticate_user!

  def index
    @weeks = Week.all
  end

  def show
    @week = Week.find(params[:id])
    @production_schedules = @week.production_schedules(current_user)
    @net_sales_by_product = @week.net_sales_by_product(current_user)
    @net_sales = @week.net_sales(current_user)
  end
end
