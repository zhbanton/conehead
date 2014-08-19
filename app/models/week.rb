class Week

  include ActiveModel::Model

  attr_reader :monday
  attr_reader :days

  def self.all
    if StartingInventory.all.empty?
      return days_to_weeks(Date.today, Date.today)
    end
    first_inventory = StartingInventory.all.order(:inventory_date).first.inventory_date
    days_to_weeks(first_inventory, Date.today)
  end

  def self.find(param)
    all.detect { |week| week.to_param == param } || raise(ActiveRecord::RecordNotFound)
  end

  def initialize(monday)
    @monday = monday
    @days = monday..(monday.at_end_of_week)
  end

  def to_param
    monday.to_formatted_s
  end

  def production_schedules(user)
    user.production_schedules.find_all { |schedule| schedule.starting_date <= days.last && schedule.ending_date >= days.first }
  end

  def net_sales_by_product(user)
    product_sold = {}
    valid_days.each do |day|
      Day.find(day.to_s).net_sales_by_product(user).each do |recipe, quantity|
        if product_sold[recipe]
          product_sold[recipe] += quantity
        else
          product_sold[recipe] = quantity
        end
      end
    end
    product_sold
  end

  def net_sales(user)
    net_sales_by_product(user).values.reduce(:+)
  end

  def to_s
    "#{monday.to_formatted_s(:long_ordinal)} - #{monday.at_end_of_week.to_formatted_s(:long_ordinal)}"
  end

  private

  def valid_days
    days.find_all { |day| Day.is_day?(day.to_s) }
  end

  def self.days_to_weeks(starting_date, ending_date)
    ((starting_date.at_beginning_of_week)..ending_date).find_all { |day| day.wday == 1 }.map { |monday| new(monday) }
  end

end
