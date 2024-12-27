require 'rails_helper'

RSpec.describe CouponService do
  describe '#purchase_coupon' do
    let(:users) { create_list(:user, TEST_COUNT) }

    TEST_COUNT = 1000

    it 'case issue coupon asynchronously' do
      coupon = create(:coupon_detail, amount: 10_000, duration_day: 10, max_amount_per_user: 1)
      latch = Concurrent::CountDownLatch.new(TEST_COUNT)
      coupon_id = coupon.id
      executor = Concurrent::ThreadPoolExecutor.new(
        min_threads: 10,
        max_threads: 10,
        queue_size: 100
      )

      users.each do |user|
        user_id = user.id
        executor.post do
          CouponService.new.purchase_coupon(user_id, coupon.id)
        rescue StandardError => e
          Rails.logger.error(e.message)
        ensure
          latch.count_down
        end
      end

      latch.wait
      
      expect(CouponWallet.count).to eq(TEST_COUNT)
      expect(CouponPurchase.where(coupon_id: coupon.id).count).to eq(TEST_COUNT)
      expect(CouponReader.new.read(coupon.id).amount).to eq(TEST_COUNT)

      executor.shutdown
      executor.wait_for_termination
    end
  end
end
