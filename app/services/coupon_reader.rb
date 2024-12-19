
class CouponReader
  
  def read(user, coupon_id)
    coupon = CouponDetail.find_by(id: coupon_id)
    raise CouponNotFound.new(coupon_id, user.id) if coupon.nil?
    return coupon
  end



end

