class CouponReader
  def read_user_coupon(user_id, coupon_id)
    coupon = CouponDetail.find_by(id: coupon_id)
    raise CouponNotFound.new(coupon_id, user_id) if coupon.nil?

    coupon
  end

  def read(coupon_id)
    coupon = CouponDetail.find_by(id: coupon_id)
    raise CouponNotFound.new(coupon_id, nil) if coupon.nil?

    left_amount = Rails.cache.fetch("coupon_amount_#{coupon_id}") do
      left_coupon_count(coupon)
    end

    CouponDto.new(coupon, left_amount)
  end

  def read_all
    coupons = CouponDetail.all

    results = []

    coupons.each do |coupon|
      left_amount = Rails.cache.fetch("coupon_amount_#{coupon.id}") do
        left_coupon_count(coupon)
      end
      results << CouponDto.new(coupon, left_amount)
    end

    results
  end

  private

  def left_coupon_count(coupon)
    coupon.amount - CouponPurchase.where(coupon_id: coupon.id).count
  end
end
