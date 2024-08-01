module V1
  module Entities
    class Users < Base
      expose :name, :email, :gender, :user_name
      
      expose :roles, with: Roles
    end
  end
end
