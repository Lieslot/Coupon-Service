require 'rails_helper'

RSpec.describe 'Coupons', type: :request do
  let(:user) { create(:user) }
  let(:coupon) { create(:coupon_detail, amount: 10, duration_day: 10) }

  # describe 'asynchronous test' do
  #   self.use_transactional_tests = false

  #   it 'should issue coupon asynchronously' do
  #     coupon = create(:coupon_detail, amount: 10_000, duration_day: 10, max_amount_per_user: 50)
  #     latch = Concurrent::CountDownLatch.new(100)

  #     executor = Concurrent::ThreadPoolExecutor.new(
  #       min_threads: 10,
  #       max_threads: 10,
  #       queue_size: 100
  #     )
  #     responses = Concurrent::Array.new

  #     mutex = Mutex.new

  #     100.times do

  #       executor.post do
  #         post issue_coupons_path, params: { coupon_id: coupon.id }
  #         responses << response.status
  #       rescue StandardError => e
  #         Rails.logger.error(e.message)
  #         mutex.synchronize { responses << 500 }
  #       ensure
  #         latch.count_down
  #       end
  #     end

  #     latch.wait

  #     expect(CouponDetail.find_by(id: coupon.id).amount).to eq(9900)
  #     expect(CouponWallet.count).to eq(100)

  #     executor.shutdown
  #     executor.wait_for_termination
  #   end
  # end

  describe 'POST /coupon' do
    describe 'success' do
      it 'should issue coupon' do
        sign_in user

        post '/coupons/issue', params: { coupon_id: coupon.id }

        expect(CouponDetail.find_by(id: coupon.id).amount).to eq(9)
      end
    end
  end
end
