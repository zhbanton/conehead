class EndingInventory < ActiveRecord::Base
  has_many :entries, as: :document, dependent: :destroy
  has_many :recipes, through: :entries
  belongs_to :user

  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true

  validates :inventory_date, { presence: true, uniqueness: { scope: :user_id } }

  def set_to_days_inventory(starting_inventory, added_inventory)
    new_entries = []
    starting_inventory.entries.each do |entry|
      new_entries << Entry.new(recipe_id: entry.recipe_id)
    end
    if added_inventory.present?
      added_inventory.added_inventory.entries.each do |entry|
        if !new_entries.find { |new_entry| new_entry.recipe_id == entry.recipe_id }
          new_entries << Entry.new(recipe_id: entry.recipe_id)
        end
      end
    end
    new_entries.each do |entry|
      entries << entry
    end
  end

end
