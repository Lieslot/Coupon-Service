require 'rails_helper'

RSpec.describe CouponIssuer do
  let(:user) { create(:user) }

  describe '#error' do
    it 'should raise CouponSoldOut error when coupon is sold out' do
      @coupon = create(:coupon_detail, amount: 0)
      expect { CouponIssuer.new.issue(user, @coupon) }.to raise_error(CouponSoldOut)
    end

    it 'should raise ExceededMaxAmountPerUser error when user exceeds max amount per user' do
      @coupon = create(:coupon_detail, max_amount_per_user: 1)
      create(:coupon_wallet, user: user, coupon_detail: @coupon)
      expect { CouponIssuer.new.issue(user, @coupon) }.to raise_error(ExceededMaxAmountPerUser)
    end
  end

  describe '#issue' do
    it 'should issue coupon' do
      @coupon = create(:coupon_detail, amount: 10, duration_day: 10)
      CouponIssuer.new.issue(user, @coupon)
      expect(CouponDetail.find_by(id: @coupon.id).amount).to eq(9)
    end
  end
end
