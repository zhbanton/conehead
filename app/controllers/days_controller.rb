class DaysController < ApplicationController

  def show
    @day = Day.find(params[:id])
  end

end
