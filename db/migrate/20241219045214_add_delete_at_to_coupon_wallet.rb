class AddDeleteAtToCouponWallet < ActiveRecord::Migration[7.1]
  def change
    add_column :coupon_wallets, :delete_at, :datetime
  end
end
