class StartingInventory < ActiveRecord::Base
  has_many :entries, as: :document, dependent: :destroy
  has_many :recipes, through: :entries
  belongs_to :user

  accepts_nested_attributes_for :entries, reject_if: :all_blank, allow_destroy: true

  validates :inventory_date, { presence: true, uniqueness: { scope: :user_id } }
end
