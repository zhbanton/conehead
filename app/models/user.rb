class User < ActiveRecord::Base

  BATCH_SIZE = 12000

  has_many :recipes, dependent: :destroy
  has_many :ingredients, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
