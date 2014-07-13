# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ending_inventory_entry, :class => 'EndingInventoryEntries' do
    recipe nil
    ending_inventory nil
    quantity 1
  end
end
