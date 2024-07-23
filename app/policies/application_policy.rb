class ApplicationPolicy

  def initialize(user)
    @user = user
  end

  def user
    @user
  end

  def is_admin?
    user.is_admin?
  end

  def is_member?
    user.is_member?
  end
  
end