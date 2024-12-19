class AddCouponDetailDuration < ActiveRecord::Migration[7.1]
  def change
    add_column :coupon_details, :duration_day, :integer
  end
end
