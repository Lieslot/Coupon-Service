class CouponIssuer
  def issue(user, coupon)
    raise CouponSoldOut.new(coupon.id, user.id) if coupon.sold_out?
    raise ExceededMaxAmountPerUser.new(coupon.id, user.id) if exceed_max_per_user?(coupon, user)

    ActiveRecord::Base.transaction do
      expire_date = Time.current + coupon.duration_day.days
      puts "expire_date: #{expire_date}"
      user_coupon =  CouponWallet.find_by(user_id: user.id, coupon_id: coupon.id, expire_date: expire_date)
      if user_coupon.nil?

        CouponWallet.create!(
          user_id: user.id,
          coupon_id: coupon.id,
          expire_date: expire_date,
          amount: 1
        )
      else
        user_coupon.increment!(:amount)
      end

        coupon.decrement!(:amount)

    end
    coupon.amount
  end

  private
  def exceed_max_per_user?(coupon, user)
    return coupon.max_amount_per_user <= CouponWallet.where(user_id: user.id, coupon_id: coupon.id).sum(:amount)
  end
end
