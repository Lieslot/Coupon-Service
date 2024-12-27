class CouponDto
  attr_reader :id, :name, :amount, :duration_day

  def initialize(coupon, amount)
    @id = coupon.id
    @name = coupon.name
    @amount = coupon.amount - amount
    @duration_day = coupon.duration_day
  end
end
