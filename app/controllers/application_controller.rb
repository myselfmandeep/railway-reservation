class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :current_user

  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to login_path unless session[:user_id]
  end

  def pagination
    {page: params[:page], per_page: 10}
  end

end
