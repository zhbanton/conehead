class GraphsController < ApplicationController

  respond_to :html, :json

  def index
    respond_with Day.all.map{ |day| day.net_sales(current_user) }
  end

end
