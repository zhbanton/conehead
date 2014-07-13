# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :added_product_entry do
    quantity 1
    recipe nil
    added_product nil
  end
end
