class AddedProductEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :added_product
end
