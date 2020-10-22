FactoryGirl.define do
  factory :discount do
    item
    discount 20.00
    discount_type 0
    count 3
    operator 2
  end
end
