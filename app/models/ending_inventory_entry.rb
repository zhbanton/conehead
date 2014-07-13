class EndingInventoryEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ending_inventory
end
