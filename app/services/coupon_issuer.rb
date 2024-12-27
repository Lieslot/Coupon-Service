class CouponIssuer
  include Retryable

  def issue(user_id, coupon)
    raise CouponSoldOut.new(coupon.id, user_id) if sold_out?(coupon)
    raise ExceededMaxAmountPerUser.new(coupon.id, user_id) if exceed_max_per_user?(coupon, user_id)

    ActiveRecord::Base.transaction do
      expire_date = Time.current + coupon.duration_day.days
      user_coupon = CouponWallet.find_by(user_id: user_id, coupon_id: coupon.id, expire_date: expire_date)

      if user_coupon.nil?

        CouponWallet.create!(
          user_id: user_id,
          coupon_id: coupon.id,
          expire_date: expire_date,
          amount: 1
        )

      else
        user_coupon.increment!(:amount)
      end

      CouponPurchase.create!(user_id: user_id, coupon_id: coupon.id)
    end

    left_amount = coupon.amount - CouponPurchase.where(coupon_id: coupon.id).count
    Rails.cache.write("coupon_amount_#{coupon.id}",
                      left_amount)

    left_amount
  end

  private

  def exceed_max_per_user?(coupon, user_id)
    coupon.max_amount_per_user <= CouponWallet.where(user_id: user_id, coupon_id: coupon.id).sum(:amount)
  end

  def sold_out?(coupon)
    CouponReader.new.read(coupon.id).amount <= 0
  end
end
