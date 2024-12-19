class CouponWallet < ApplicationRecord
  belongs_to :user, :coupon_detail

  

end
