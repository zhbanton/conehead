FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(10) }
  end
end

FactoryGirl.define do
  factory :recipe do # turns into camel case class name and looks for class of that name
    name { %w(chocolate vanilla strawberry cinnamon coffee pistachio caramel).sample } # need to pass a block to make it use a different name each time a new player is created
    note { Faker::Lorem.sentence}
    created_at { Faker::Business.credit_card_expiry_date }
  end
end

FactoryGirl.define do
  factory :ingredient do # turns into camel case class name and looks for class of that name
    name { Faker::Lorem.word } # need to pass a block to make it use a different name each time a new player is created
  end
end
