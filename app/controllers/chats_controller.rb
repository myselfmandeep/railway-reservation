class ChatsController < ApplicationController

  def conversation

    # super_admin_users = User.joins(:roles).where(roles: {name: "superadmin"})
    # non_admin_users = User.joins(:roles).where.not(roles: { name: "superadmin" }).and.where.not(id: super_admin_users.ids).group('users.id')

    
    super_admin_users = User.joins(:roles).where(roles: { name: "superadmin" })
    non_admin_users = User.joins(:roles)
                      .where.not(roles: { name: "superadmin" })
                      .where.not(id: super_admin_users.ids)
                      .distinct
    @users = current_user.is_superadmin?  ? non_admin_users : super_admin_users
  end

  def get_current_user
    id = current_user.id
    token = JwtToken.encode({user_id: id})
    render json: {user_id: id, token: token}
  end
  
end