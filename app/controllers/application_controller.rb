class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  helper_method :current_user, :user_signed_in?
  rescue_from ExceededMaxAmountPerUser, with: :exceeded_max_amount_per_user
  rescue_from CouponSoldOut, with: :coupon_sold_out
  private


  def exceeded_max_amount_per_user
    render json: { message: 'Coupon issue has reached to limit' }, status: :bad_request
  end


  def coupon_sold_out
    render json: { message: 'Coupon sold out' }, status: :bad_request
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
