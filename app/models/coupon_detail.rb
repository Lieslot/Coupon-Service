class CouponDetail < ApplicationRecord
  acts_as_paranoid

  def sold_out?
      if self.amount < 0
          Rails.logger.error("coupon amount is negative; coupon: #{self.id}")
      end

      return self.amount <= 0 
  end

end
