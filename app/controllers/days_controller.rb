class DaysController < ApplicationController

  before_action :authenticate_user!

  def index
    days = current_user.production_schedules.order(:starting_date).first.starting_date.at_beginning_of_week..(Date.today.at_beginning_of_week + 3.weeks)
    @mondays = days.select { |day| day.wday == 1 }
  end

  def view_week
    monday = params[:day].to_date
    @weekdays = monday..monday.at_end_of_week
  end

  def view_day
    @day = params[:day].to_date
    @starting_inventory = current_user.starting_inventories.where(inventory_date: @day)
  end

end
