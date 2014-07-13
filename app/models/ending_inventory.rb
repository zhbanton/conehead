class EndingInventory < ActiveRecord::Base
  has_many :ending_inventory_entries, dependent: :destroy
  has_many :recipes, through: :ending_inventory_entries
  belongs_to :user

  accepts_nested_attributes_for :ending_inventory_entries, reject_if: :all_blank, allow_destroy: true

  validates :inventory_date, { presence: true, uniqueness: { scope: :user_id } }

  def set_to_days_inventory(starting_inventory, added_inventory)
    new_entries = []
    starting_inventory.starting_inventory_entries.each do |entry|
      new_entries << EndingInventoryEntry.new(recipe_id: entry.recipe_id)
    end
    if added_inventory.present?
      added_inventory.added_inventory_entries.each do |entry|
        if !new_entries.find { |new_entry| new_entry.recipe_id == entry.recipe_id }
          new_entries << EndingInventoryEntry.new(recipe_id: entry.recipe_id)
        end
      end
    end
    new_entries.each do |entry|
      ending_inventory_entries << entry
    end
  end

end
