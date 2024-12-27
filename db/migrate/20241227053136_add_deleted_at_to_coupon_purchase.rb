class AddDeletedAtToCouponPurchase < ActiveRecord::Migration[7.1]
  def change
    add_column :coupon_purchases, :deleted_at, :datetime
  end
end
