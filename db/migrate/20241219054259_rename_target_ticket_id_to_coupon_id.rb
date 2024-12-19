class RenameTargetTicketIdToCouponId < ActiveRecord::Migration[7.1]
  def change
    rename_column :coupon_wallets, :target_ticket_id, :coupon_id
  end
end
