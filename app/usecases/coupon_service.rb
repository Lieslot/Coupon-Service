class CouponService
  def purchase_coupon(user_id, coupon_id)
    coupon = CouponReader.new.read_user_coupon(user_id, coupon_id)
    CouponIssuer.new.issue(user_id, coupon)
  end
end
