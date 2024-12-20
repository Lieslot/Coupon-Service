class CouponIssuer
  def issue(user, coupon)
    raise CouponSoldOut.new(coupon.id, user.id) if coupon.sold_out?
    raise ExceededMaxAmountPerUser.new(coupon.id, user.id) if CouponWallet.where(user_id: user.id,
                                                                                 coupon_id: coupon.id).count >= coupon.max_amount_per_user

    ActiveRecord::Base.transaction do
      CouponWallet.create!(
        user_id: user.id,
        coupon_id: coupon.id,
        expire_date: Time.now + coupon.duration_day
      )
      coupon.decrement!(:amount)
    end
    coupon.amount
  end
end
