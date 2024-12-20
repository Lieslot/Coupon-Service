
class ExceededMaxAmountPerUser < CouponError
  def initialize(coupon_id, user_id)
    super("Exceeded max amount per user; coupon: #{coupon_id} user: #{user_id}")
  end
end
