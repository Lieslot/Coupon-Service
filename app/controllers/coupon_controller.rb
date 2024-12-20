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

  def new
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

  def index
    @coupon_details = CouponDetail.all
    render 'coupon/list'
  end

  def wallet
    @coupon_wallets = CouponWallet.where(user_id: current_user.id).includes(:coupon_detail)
    render 'coupon/wallet'
  end

  def issue
    begin
      coupon = CouponReader.new.read(current_user, params[:coupon_id])
      left_coupon_amount = CouponIssuer.new.issue(current_user, coupon)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Validation error: #{e.message}")
      render json: {message: e.message}, status: :unprocessable_entity
      return 
    rescue StandardError => e
      Rails.logger.error("Failed to issue coupon: #{e.message}")
      render json: {message: e.message}, status: :internal_server_error
      return
    end

    render json: { message: 'Coupon issued successfully', left_amount: left_coupon_amount }, status: :ok
  end
end
