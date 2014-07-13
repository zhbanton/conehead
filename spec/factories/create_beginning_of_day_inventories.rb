# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :create_beginning_of_day_inventory, :class => 'CreateBeginningOfDayInventories' do
    date "2014-07-12"
  end
end
