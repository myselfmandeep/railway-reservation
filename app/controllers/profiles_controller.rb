class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit]

  def show
    # raise ::Policy::Error
  end

  def edit
  end
  
  private

  def set_user
    @user = current_user
  end
end