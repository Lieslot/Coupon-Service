
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    if authenticated_user = User.find_by(id: cookies.encrypted[:user_id])
      Current.user = authenticated_user
    else
      redirect_to new_session_url
    end
  end

end