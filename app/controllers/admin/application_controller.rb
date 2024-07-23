module Admin
  class ApplicationController < ApplicationController
    # include AdminAuthorization
    before_action :authorize_admin

    private

    def authorize_admin
      redirect_to root_path, alert: "You are not a admin." unless current_user && current_user.is_admin?
    end
  end
end