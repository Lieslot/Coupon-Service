class CouponDetail < ApplicationRecord
  acts_as_paranoid

  def sold_out?
    Rails.logger.error("coupon amount is negative; coupon: #{id}") if amount < 0

    amount <= 0
  end
end
