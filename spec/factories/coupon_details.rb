FactoryBot.define do
  factory :coupon_detail do
    amount { 1 }
    name { 'MyString' }
    max_amount_per_user { 1 }
    discount_value { 1 }
    duration_day { 1 }
  end
end
