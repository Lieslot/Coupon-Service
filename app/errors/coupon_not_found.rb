class CouponNotFound < CouponError
  def initialize(coupon_id, user_id)
    super("Coupon not found; coupon: #{coupon_id} user: #{user_id}")
  end
end