class Recipe < ActiveRecord::Base

  before_create :quantity_to_zero, :downcase_name
  belongs_to :user
  has_many :recipe_entries, dependent: :destroy
  has_many :ingredients, through: :recipe_entries
  has_many :production_schedule_entries
  has_many :production_schedules, through: :production_schedule_entries
  has_many :beginning_of_day_inventory_entries

  accepts_nested_attributes_for :recipe_entries, reject_if: proc { |attributes| attributes['quantity'].blank? && attributes['ingredient_attributes']['name'].blank? }, allow_destroy: true

  validates :name, { presence: true, uniqueness: { scope: :user_id } }

  def yield
    recipe_entries.map(&:quantity).reduce(:+)
  end

  def to_batch_size
    recipe_entries.each { |entry| entry.quantity *= (User::BATCH_SIZE / entry.recipe.yield) }
    self
  end

  def most_recent_production_date
    production_schedules.order(:starting_date).last
  end

  def quantity_to_zero
    self.recipe_entries.each do |entry|
      if entry.quantity == nil
        entry.quantity = 0
      end
    end
  end

  def downcase_name
    self.name = name.downcase
  end

end
