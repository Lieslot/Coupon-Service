# t.string "email", default: "", null: false
# t.string "encrypted_password", default: "", null: false
# t.string "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "nickname"
# t.index ["email"], name: "index_users_on_email", unique: true
# t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

class User < ApplicationRecord
  enum role: { user: 0, admin: 1, guest: 2 }

  has_many :coupon_wallets, dependent: :destroy

  before_create :set_default_role

  after_initialize :set_default_role, if: :new_record?

  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_default_role
    return self.role = :admin if id == 1

    self.role ||= :user
  end
end
