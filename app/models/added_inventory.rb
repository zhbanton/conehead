class AddedInventory < ActiveRecord::Base
  has_many :added_inventory_entries, dependent: :destroy
  has_many :recipes, through: :added_inventory_entries
  belongs_to :user

  accepts_nested_attributes_for :added_inventory_entries, reject_if: :all_blank, allow_destroy: true

  validates :inventory_date, { presence: true, uniqueness: { scope: :user_id } }

end
