class User < ActiveRecord::Base

  BATCH_SIZE = 12000

  has_many :recipes, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :production_schedules, dependent: :destroy
  has_many :starting_inventories, dependent: :destroy
  has_many :ending_inventories, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
