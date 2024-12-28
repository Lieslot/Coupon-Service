class CouponDto
  attr_reader :id, :name, :amount, :discount_value, :duration_day, :max_amount_per_user

  def initialize(coupon, amount)
    @id = coupon.id
    @name = coupon.name
    @amount = amount
    @discount_value = coupon.discount_value
    @max_amount_per_user = coupon.max_amount_per_user
    @duration_day = coupon.duration_day
  end
end
