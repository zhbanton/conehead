class EndingInventory < ActiveRecord::Base
  has_many :ending_inventory_entries, dependent: :destroy
  has_many :recipes, through: :ending_inventory_entries
  belongs_to :user

  accepts_nested_attributes_for :ending_inventory_entries, reject_if: :all_blank

  validates :inventory_date, { presence: true, uniqueness: { scope: :user_id } }

  def set_to_starting_inventory(starting_inventory)
    starting_inventory.starting_inventory_entries.each do |entry|
      ending_inventory_entries << EndingInventoryEntry.new(recipe_id: entry.recipe_id)
    end
  end

end
