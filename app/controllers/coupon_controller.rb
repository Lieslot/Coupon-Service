class CouponController < ApplicationController
  before_action :check_user, only: %i[issue wallet]
  before_action :check_admin, only: %i[create new]


  def check_user
    return if current_user.user? || current_user.admin?

    head :unauthorized
  end

  def check_admin
    return if current_user.admin?

    head :unauthorized
  end

  # TODO: 새로운 쿠폰 생성 화면
  def new
    # TODO: 화면 만들기기
    @coupon_detail = CouponDetail.new
    render '/coupon/new_coupon'
  end

  def create
    
  
    @coupon_detail = CouponDetail.create!(coupon_params)

    redirect_to list_coupons_path
  end

  def coupon_params
    params.require(:coupon_detail).permit(:name, :amount, :max_amount_per_user, :discount_value, :duration_day)
  end

  # TODO: 유저가 발급 가능한 쿠폰 목록 조회 화면
  def index
    @coupon_details = CouponDetail.all
    render 'coupon/list'
  end

  # TODO: 유저가 사용 가능한 쿠폰 조회 화면(쿠폰 지갑)
  def wallet
    render wallet_coupons_path
  end

  def issue
    begin
      coupon = CouponReader.new.read(current_user, params[:coupon_id])
      left_coupon_amount = CouponIssuer.new.issue(current_user, coupon)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Validation error: #{e.message}")
      return head :unprocessable_entity
    rescue StandardError => e
      Rails.logger.error("Failed to issue coupon: #{e.message}")
      return head :unprocessable_entity
    end

    render json: { message: 'Coupon issued successfully', left_amount: left_coupon_amount }, status: :ok
  end
end
