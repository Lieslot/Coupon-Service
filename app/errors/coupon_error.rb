

class CouponError < StandardError
  def initialize(message = 'Coupon exception occurred')
    super(message)
  end
end

class CouponNotFound < CouponError
    def initialize(coupon_id, user_id)
      super("Coupon not found; coupon: #{coupon_id} user: #{user_id}")
    end
end

class CouponSoldOut < CouponError
  def initialize(coupon_id, user_id)
    super("Coupon sold out; coupon: #{coupon_id} user: #{user_id}")
  end
end

class ExceededMaxAmountPerUser < CouponError
  def initialize(coupon_id, user_id)
    super("Exceeded max amount per user; coupon: #{coupon_id} user: #{user_id}")
  end
end