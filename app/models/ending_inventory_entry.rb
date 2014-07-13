class EndingInventoryEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ending_inventory

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :recipe_id, presence: true
end

def starting_inventory(user)
  user.starting_inventories.where(inventory_date: :inventory_date)
end

def new_with_starting_inventory(user)

end
