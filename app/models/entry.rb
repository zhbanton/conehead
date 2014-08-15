class Entry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :document, polymorphic: true

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :recipe_id, presence: true
end

