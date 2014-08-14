class DaysController < ApplicationController

  before_action :authenticate_user!

  def show
    @day = Day.find(params[:id])
  end

end
