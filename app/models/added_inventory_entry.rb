class AddedInventoryEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :added_inventory

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :recipe_id, presence: true
end
