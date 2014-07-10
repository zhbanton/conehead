class ProductionSchedulesController < ApplicationController

  before_action :authenticate_user!

  def index
    @production_schedules = current_user.production_schedules.order(starting_date: :desc)
  end

  def new
    @production_schedule = current_user.production_schedules.new
    @recipe_select = Recipe.all.map { |r| [r.name,r.id] }
  end

  def create
    @production_schedule = current_user.production_schedules.new(production_schedule_params)
    if @production_schedule.save
      redirect_to production_schedules_path, notice: "Production schedule for period starting #{@production_schedule.starting_date.to_formatted_s(:long_ordinal)}"
    else
      flash.now[:alert] = @production_schedule.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def production_schedule_params
    params.require(:production_schedule).permit(:starting_date, :ending_date, production_schedule_entries_attributes: [:id, :quantity, :production_schedule_id, :recipe_id])
  end

end
