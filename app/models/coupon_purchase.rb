class CouponPurchase < ApplicationRecord
  acts_as_paranoid

  belongs_to :coupon_detail, foreign_key: :coupon_id
  

end
