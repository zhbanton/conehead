class Day

  include ActiveModel::Model

  attr_reader :date

  def self.all
    if StartingInventory.all.empty?
      return [Date.today]
    end
    inventories = StartingInventory.all.order(:inventory_date)
    (inventories.first.inventory_date..(Date.today + 2.weeks)).map{ |day| new(day) }
  end

  def self.find(param)
    all.detect { |day| day.to_param == param } || raise(ActiveRecord::RecordNotFound)
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

  def ending_inventory(user)
    user.ending_inventories.where(inventory_date: date).first
  end

  def net_sales(user)
    product_sold = {}
    return product_sold if starting_inventory(user) == nil
    return net_sales_without_ending_inventory(user) if ending_inventory(user) == nil
    starting_inventory(user).starting_inventory_entries.each do |entry|
      if product_sold[entry.recipe.name]
        product_sold[entry.recipe.name] += entry.quantity
      else
        product_sold[entry.recipe.name] = entry.quantity
      end
    end
    ending_inventory(user).ending_inventory_entries.each do |entry|
      if product_sold[entry.recipe.name]
        product_sold[entry.recipe.name] -= entry.quantity
      else
        product_sold[entry.recipe.name] = 0
      end
    end
    product_sold
  end

  def net_sales_without_ending_inventory(user)
    products = {}
    starting_inventory(user).starting_inventory_entries.each do |entry|
      products[entry.recipe.name] = 0
    end
    products
  end

end
