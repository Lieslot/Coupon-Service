FactoryBot.define do
  factory :coupon_wallet do
    amount { 1 }
    target_ticket_id { 1 }
    user_id { 1 }
    expire_date { "2024-12-19" }
  end
end
