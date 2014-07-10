class Recipe < ActiveRecord::Base

  belongs_to :user
  has_many :recipe_entries, dependent: :destroy
  has_many :ingredients, through: :recipe_entries
  has_many :production_schedule_entries
  accepts_nested_attributes_for :recipe_entries, reject_if: proc { |attributes| attributes['quantity'].blank? }
  accepts_nested_attributes_for :ingredients

  validates :name, { presence: true, uniqueness: { scope: :user_id } }

  def yield
    recipe_entries.map(&:quantity).reduce(:+)
  end

  def to_batch_size
    recipe_entries.each { |entry| entry.quantity *= (User::BATCH_SIZE / entry.recipe.yield) }
    self
  end

end
