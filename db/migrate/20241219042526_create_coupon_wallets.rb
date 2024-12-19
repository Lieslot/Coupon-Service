class CreateCouponWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :coupon_wallets do |t|
      t.integer :amount
      t.integer :target_ticket_id
      t.integer :user_id
      t.date :expire_date

      t.timestamps
    end
  end
end
