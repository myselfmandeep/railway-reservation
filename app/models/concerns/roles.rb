module Roles
  extend ActiveSupport::Concern

  def has_role?(role)
    user_roles.exists?(role: get_role(role))
  end
  
  Role.pluck(:name).each do |name|
    define_method "is_#{name}?" do
      has_role?(name)
    end
  end

  # def is_admin?
  #   has_role?(Role::ADMIN) 
  # end

  # def is_member?
  #   has_role?(Role::MEMBER)
  # end

  def add_role(role_name)
    role = user_roles.new(role: get_role(role_name))

    role.save!
  end

  def remove_role(role_name)
    u_roles = user_roles.find_by(role: get_role(role_name))

    u_roles.nil? ? "User does not have #{role.name} role" : u_roles.destroy
  end

  private

  def get_role(name)
    Role.find_by(name: name)
  end

end
