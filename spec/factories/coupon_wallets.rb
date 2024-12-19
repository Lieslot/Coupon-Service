FactoryBot.define do
  factory :coupon_wallet do
    
    amount { 1 }
    association :user
    association :coupon_id, factory: :coupon_detail
    expire_date { 7.days.from_now } # 기본적으로 현재 시점에서 7일 뒤로 설정

  end
end

