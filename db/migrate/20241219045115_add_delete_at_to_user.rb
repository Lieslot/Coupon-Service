class AddDeleteAtToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :delete_at, :datetime
  end
end
