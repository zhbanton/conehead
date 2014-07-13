class DaysController < ApplicationController

before_action :authenticate_user!

  def index
    @days = Day.all
  end

  def show
    @day = Day.find(params[:id])
  end

  def weeks
  end

end
