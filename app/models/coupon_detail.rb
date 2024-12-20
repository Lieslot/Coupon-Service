class CouponDetail < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :max_amount_per_user, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :discount_value, presence: true

  def sold_out?
    Rails.logger.error("coupon amount is negative; coupon: #{id}") if amount < 0

    amount <= 0
  end
end
