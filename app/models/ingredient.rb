class Ingredient < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_entries
  has_many :recipes, through: :recipe_entries

  validates :name, { presence: true, uniqueness: { scope: :user_id} }
end
