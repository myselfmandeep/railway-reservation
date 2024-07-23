class SessionsController < ApplicationController
  # skip_before_action :authenticate, only: %i[login verify forgot reset]
  skip_before_action :authenticate, except: %i[welcome destroy]
  
  def welcome
    redirect_to admin_dashboard_path if current_user.is_admin?
  end

  def login
  end

  def verify
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      if @user.account_status == User::BLOCK
        flash[:notice] = "your account has been blocked"
        render :login, status: 401
      else
        # UserMailer.welcome_email(@user).deliver_now
        session[:user_id] = @user.id
        redirect_to root_path
      end
    else
      flash[:notice] = "Invalid credentials"
      render :login, status: 401
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path, notice: "Logout successfully"
  end

  def forgot
    # @user = User.first
  end

  def reset
    fp                    = params[:forgot_password]
    email                 = fp[:email]
    token                 = fp[:password_reset_token]
    password              = fp[:password]
    password_confirmation = fp[:password_confirmation]
    @user                 = User.find_by(email: email)

    if @user.reset_token == token
      @user.update(password: password, password_confirmation: password_confirmation)
      redirect_to login_path, notice: "password reset sucessfully"
    else
      render :forgot, notice: "something went wrong"
    end
    
  end

  private

  def password_forgot_params
    params.require(:forgot_password).permit(:email, :password_reset_token, :password, :password_confirmation)
  end
  

end
