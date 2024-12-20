class CouponSoldOut < CouponError
  def initialize(coupon_id, user_id)
    super("Coupon sold out; coupon: #{coupon_id} user: #{user_id}")
  end
end