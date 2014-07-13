# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ending_inventory do
    user nil
    employee "MyString"
    inventory_date "2014-07-13"
  end
end
