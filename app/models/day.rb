class Day

  attr_reader :date

  def self.all
    if StartingInventory.all.empty?
      return [Date.today]
    end
    inventories = StartingInventory.all.order(:inventory_date)
    (inventories.first.inventory_date..(inventories.last.inventory_date + 2.weeks)).map{ |day| new(day) }
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

  def starting_inventories
    StartingInventory.all.where(inventory_date: @date)
  end

end
