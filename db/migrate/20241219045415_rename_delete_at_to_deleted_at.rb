class RenameDeleteAtToDeletedAt < ActiveRecord::Migration[7.1]
  def change
    rename_column :coupon_details, :delete_at, :deleted_at
    rename_column :coupon_wallets, :delete_at, :deleted_at
    rename_column :users, :delete_at, :deleted_at
  end
end
