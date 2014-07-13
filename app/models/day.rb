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

  def net_sales(starting_inventory, ending_inventory)
    product_sold = {}
    starting_inventory.starting_inventory_entries.each do |entry|
      if product_sold[entry.recipe.name]
        product_sold[entry.recipe.name] += entry.quantity
      else
        product_sold[entry.recipe.name] = entry.quantity
      end
    end
    ending_inventory.ending_inventory_entries.each do |entry|
      if product_sold[entry.recipe.name]
        product_sold[entry.recipe.name] -= entry.quantity
      else
        product_sold[entry.recipe.name] = 0
      end
    end
    product_sold
  end

end
