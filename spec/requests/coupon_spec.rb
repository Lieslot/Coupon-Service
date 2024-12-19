require 'rails_helper'

RSpec.describe 'Coupons', type: :request do
  let(:user) { create(:user) }
  let(:coupon) { create(:coupon_detail, amount: 10, duration_day: 10) }

  describe 'POST /coupon' do
     describe 'success' do
      
      it 'should issue coupon' do
        
        sign_in user
        
        post '/coupons/issue', params: {coupon_id: coupon.id}
        
        expect(CouponDetail.find_by(id: coupon.id).amount).to eq(9)
      end

    end 
  end
end


