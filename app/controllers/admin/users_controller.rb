module Admin
  class UsersController < Admin::ApplicationController
    skip_before_action :authenticate, only: %i[new create]
    skip_before_action :authorize_admin, except: %i[index]
    before_action :set_user, only: %i[show edit update assign_role account_status]
    
    def index
      @users = User.all
    end
    
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(user_params)
      
      if @user.save
        UserMailer.welcome_email(@user).deliver_now
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Successfully created user"
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def show
      # code
    end

    def edit
      # code
    end

    def update
      if @user.update(user_params)
        redirect_to root_path, notice: "User profile successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def assign_role
      role = Role.find(params[:role_id])
      @user_roles = @user.user_roles.create(role: role)

      @roles = @user.roles

      respond_to do |format|
        format.js
      end
    end

    def account_status
      case @user.account_status
      when User::ACTIVE
        @user.update(account_status: User::BLOCK)
      when User::BLOCK
        @user.update(account_status: User::ACTIVE)
      end

      redirect_to admin_users_path, notice: "#{@user.name} status has been changed to #{@user.account_status}"
    end

    # def destroy
    # end
    
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_name, :gender).merge!({reset_token: SecureRandom.urlsafe_base64})
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
  end
end