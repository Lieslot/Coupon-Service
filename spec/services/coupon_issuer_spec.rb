require 'rails_helper'
require 'concurrent-ruby'

RSpec.describe CouponIssuer do
  let(:user) { create(:user) }

  describe '#error' do
    it 'should raise CouponSoldOut error when coupon is sold out' do
      @coupon = create(:coupon_detail, amount: 1)
      CouponIssuer.new.issue(user, @coupon)
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

  describe 'asynchronous test' do
    self.use_transactional_tests = false

    TEST_COUNT = 100

    it 'should issue coupon asynchronously' do
      coupon = create(:coupon_detail, amount: 10_000, duration_day: 10, max_amount_per_user: 50)
      latch = Concurrent::CountDownLatch.new(TEST_COUNT)

      executor = Concurrent::ThreadPoolExecutor.new(
        min_threads: 10,
        max_threads: 10,
        queue_size: 100
      )

      mutex = Mutex.new

      100.times do
        
        executor.post do


          auser = create(:user)


          CouponIssuer.new.issue(auser, coupon)

        rescue StandardError => e
          Rails.logger.error(e.message)
        ensure
          latch.count_down
        end
      end

      latch.wait

      expect(CouponDetail.find_by(id: coupon.id).amount).to eq(10000 - TEST_COUNT)
      expect(CouponWallet.count).to eq(TEST_COUNT)

      executor.shutdown
      executor.wait_for_termination
    end
  end

end

