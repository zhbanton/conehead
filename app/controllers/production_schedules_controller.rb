class ProductionSchedulesController < ApplicationController

  before_action :authenticate_user!, :set_production_schedule, only: [:show, :edit, :update, :destroy]
  before_action :set_recipe_select, only: [:new, :edit, :create, :update]

  def index
    @production_schedules = current_user.production_schedules.order(starting_date: :desc)
  end

  def show
    @required_ingredients = @production_schedule.list_required_ingredients
  end

  def new
    @production_schedule = current_user.production_schedules.new
  end

  def create
    @production_schedule = current_user.production_schedules.new(production_schedule_params)
    if @production_schedule.save
      redirect_to production_schedule_path(@production_schedule), notice: "Production schedule for period starting #{@production_schedule.starting_date.to_formatted_s(:long_ordinal)} created"
    else
      flash.now[:alert] = @production_schedule.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @production_schedule.update(production_schedule_params)
      redirect_to production_schedules_path, notice: "Production schedule for period starting #{@production_schedule.starting_date.to_formatted_s(:long_ordinal)} updated"
    else
      flash.now[:alert] = @production_schedule.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @production_schedule.destroy
    redirect_to production_schedules_path, notice: "Production schedule for period starting #{@production_schedule.starting_date.to_formatted_s(:long_ordinal)} deleted"
  end

  private

  def production_schedule_params
    params.require(:production_schedule).permit(:starting_date, production_schedule_entries_attributes: [:id, :quantity, :production_schedule_id, :recipe_id])
  end

  def set_production_schedule
    @production_schedule = ProductionSchedule.find(params[:id])
  end

  def set_recipe_select
    @recipe_select = Recipe.where(is_active: true).map { |r| [r.name,r.id] }
  end

end
