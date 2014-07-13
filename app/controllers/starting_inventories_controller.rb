class StartingInventoriesController < ApplicationController
  def new
    @starting_inventory = current_user.starting_inventories.new
  end

end
