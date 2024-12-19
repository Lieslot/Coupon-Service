class CouponWallet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :coupon_detail, foreign_key: :coupon_id
end
