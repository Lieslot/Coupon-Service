class CreateCouponDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :coupon_details do |t|
      t.integer :amount
      t.string :name
      t.integer :max_amount_per_user
      t.integer :discount_value

      t.timestamps
    end
  end
end
