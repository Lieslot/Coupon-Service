class CouponError < StandardError
  def initialize(message = 'Coupon exception occurred')
    super(message)
  end
end
