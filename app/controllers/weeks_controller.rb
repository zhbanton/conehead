class WeeksController < ApplicationController

  before_action :authenticate_user!

  def index
    @weeks = Week.all
  end

  def show
    @week = Week.find(params[:id])
  end
end
