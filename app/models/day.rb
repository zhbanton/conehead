class Day

  include ActiveModel::Model

  attr_reader :date

  def self.all
    if StartingInventory.all.empty?
      return [new(Date.today)]
    end
    first_inventory = StartingInventory.all.order(:inventory_date).first.inventory_date
    (first_inventory..Date.today).map{ |day| new(day) }
  end

  def self.find(param)
    all.detect { |day| day.to_param == param } || raise(ActiveRecord::RecordNotFound)
  end

  def self.is_day?(param)
    begin
      self.find(param)
      return true
    rescue ActiveRecord::RecordNotFound => ex
      false
    end
  end

  def initialize(date)
    @date = date
  end

  def to_param
    @date.to_formatted_s
  end

  def starting_inventory(user)
    user.starting_inventories.where(inventory_date: date).first
  end

  def added_inventory(user)
    user.added_inventories.where(inventory_date: date).first
  end

  def ending_inventory(user)
    user.ending_inventories.where(inventory_date: date).first
  end

  def production_schedules(user)
    user.production_schedules.find_all { |schedule| schedule.starting_date <= date && schedule.ending_date >= date }
  end

  def net_sales_by_product(user)
    product_sold = {}
    return product_sold if starting_inventory(user).nil?
    return net_sales_without_ending_inventory(user) if ending_inventory(user).nil?

    starting_inventory(user).entries.each do |entry|
      if product_sold[entry.recipe.name]
        product_sold[entry.recipe.name] += entry.quantity
      else
        product_sold[entry.recipe.name] = entry.quantity
      end
    end

    if added_inventory(user).present?
      added_inventory(user).entries.each do |entry|
        if product_sold[entry.recipe.name]
          product_sold[entry.recipe.name] += entry.quantity
        else
          product_sold[entry.recipe.name] = entry.quantity
        end
      end
    end

    ending_inventory(user).entries.each do |entry|
      if product_sold[entry.recipe.name]
        product_sold[entry.recipe.name] -= entry.quantity
      else
        product_sold[entry.recipe.name] = 0
      end
    end
    product_sold
  end

  def net_sales(user)
    net_sales_by_product(user).values.reduce(:+)
  end

  private

  def net_sales_without_ending_inventory(user)
    products = {}
    starting_inventory(user).entries.each do |entry|
      products[entry.recipe.name] = 0
    end
    if added_inventory(user)
      added_inventory(user).entries.each do |entry|
        products[entry.recipe.name] = 0
      end
    end
    products
  end

end
