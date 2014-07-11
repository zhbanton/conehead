class Ingredient < ActiveRecord::Base
  before_create :downcase_name

  belongs_to :user
  has_many :recipe_entries
  has_many :recipes, through: :recipe_entries

  validates :name, { presence: true, uniqueness: { scope: :user_id} }

  def downcase_name
    self.name = name.downcase
  end

end
