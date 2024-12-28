require 'rails_helper'

RSpec.describe 'Coupons', type: :request do
  let(:user) { create(:user) }
  let(:coupon) { create(:coupon_detail, amount: 10, duration_day: 10) }

  # describe 'asynchronous test' do
  #   it 'should issue coupon asynchronously' do
  #     TEST_COUNT = 100
  #     users = create_list(:user, TEST_COUNT)
  #     coupon = create(:coupon_detail, amount: 10_000, duration_day: 10, max_amount_per_user: 50)
  #     latch = Concurrent::CountDownLatch.new(TEST_COUNT)
  #
  #     executor = Concurrent::ThreadPoolExecutor.new(
  #       min_threads: 10,
  #       max_threads: 10,
  #       queue_size: 100
  #     )
  #     responses = Concurrent::Array.new
  #     user_ids = Concurrent::Set.new
  #     mutex = Mutex.new
  #
  #     users.each do |user|
  #       executor.post do
  #         sign_in user
  #
  #         post issue_coupons_path, params: { coupon_id: coupon.id }
  #
  #
  #
  #         user_ids << user.id
  #
  #         responses << response.status
  #       rescue StandardError => e
  #         Rails.logger.error(e.message)
  #         mutex.synchronize { responses << 500 }
  #       ensure
  #         latch.count_down
  #       end
  #     end
  #
  #     latch.wait
  #
  #     puts responses.inspect
  #     puts user_ids.count
  #
  #     expect(CouponReader.new.read(coupon.id).amount).to eq(10_000 - TEST_COUNT)
  #     expect(CouponWallet.count).to eq(TEST_COUNT)
  #     executor.shutdown
  #     executor.wait_for_termination
  #   end
  # end

  describe 'POST /coupon' do
    describe 'success' do
      it 'should issue coupon' do
        sign_in user

        post issue_coupons_path, params: { coupon_id: coupon.id }

        expect(CouponReader.new.read(coupon.id).amount).to eq(9)
      end
    end
  end
end
