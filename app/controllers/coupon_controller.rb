class CouponController < ApplicationController

  before_action :check_guest, only: [:issue]
  before_action :check_admin, only: [:create, :new]  


  def check_guest
    if current_user.guest?
      return head :unauthorized
    end
  end

  def check_admin
    if !current_user.admin?
      return head :unauthorized
    end
  end


  # TODO: 새로운 쿠폰 생성 화면
  def new
    # TODO 화면 만들기기

    return render 'coupon/new_coupon'
  end

  def create
    @coupon_detail = CouponDetail.create!(name: params[:name], 
    amount: params[:amount], 
    max_amount_per_user: 
    params[:max_amount_per_user], 
    discount_value: params[:discount_value],
    duration_day: params[:duration_day]
    )

    return redirect_to '/coupon/list'
  end

  # TODO: 유저가 발급 가능한 쿠폰 목록 조회 화면
  def index

    @coupons = CouponDetail.all
    return render 'coupon/list'
  end

  # TODO: 유저가 사용 가능한 쿠폰 조회 화면(쿠폰 지갑) 
  def wallet

    return render 'coupon/wallet'
  end


  def issue

    begin
      @coupon = CouponReader.new.read(current_user, params[:coupon_id])
      @coupon_issuer = CouponIssuer.new.issue(current_user, @coupon)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Validation error: #{e.message}")
      return head :unprocessable_entity
    rescue => e
      Rails.logger.error("Failed to issue coupon: #{e.message}")
      return head :unprocessable_entity
    end
    
    render json: { message: "Coupon issued successfully"}, status: :ok
  end


  
  
end
