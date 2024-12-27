# id: integer (PK)

# amount: integer

# name: string

# max_amount_per_user: integer

# discount_value: integer

# created_at: datetime - not null

# updated_at: datetime - not null

# deleted_at: datetime

# duration_day: intege
class CouponDetail < ApplicationRecord
  acts_as_paranoid

  has_many :coupon_wallets, dependent: :destroy

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :max_amount_per_user, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :discount_value, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def sold_out?
    Rails.logger.error("coupon amount is negative; coupon: #{id}") if amount < 0

    amount <= 0
  end
end
