# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "Old Sombrero"
    price 10
    period "day"
    description "Still good"
  end
end
