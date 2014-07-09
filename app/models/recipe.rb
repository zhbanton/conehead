class Recipe < ActiveRecord::Base
    belongs_to :user
    has_many :recipe_entries, dependent: :destroy
    has_many :ingredients, through: :recipe_entries, dependent: :destroy
    accepts_nested_attributes_for :ingredients
    accepts_nested_attributes_for :recipe_entries, reject_if: :all_blank, allow_destroy: true


    validates :name, { presence: true, uniqueness: { scope: :user_id} }
end
