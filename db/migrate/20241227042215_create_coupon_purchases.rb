class CreateCouponPurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :coupon_purchases do |t|
      t.integer :user_id
      t.string :coupon_id
      t.string :integer

      t.timestamps
    end
  end
end
