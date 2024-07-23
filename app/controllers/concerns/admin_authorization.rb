module AdminAuthorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize_admin
  end

  def authorize_admin
    unless current_user && current_user.is_admin?
      redirect_to root_path, alert: "You are not a admin."
    end
  end
end
