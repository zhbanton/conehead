# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beginning_of_day_inventory_entry do
    recipe nil
    beginning_of_day_inventory_references "MyString"
    quantity 1
  end
end
