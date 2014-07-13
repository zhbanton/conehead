class EndingInventoryEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ending_inventory

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :recipe_id, presence: true
end
