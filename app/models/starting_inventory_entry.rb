class StartingInventoryEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :starting_inventory

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
