module V1
  module Auth
    class Sessions < Grape::API

      namespace :session do
        desc "login user"
        params do
          requires :creds, type: Hash do
            requires :email,    type: String
            requires :password, type: String
          end
        end
        post do
          user = User.find_by(email: params[:creds][:email])
          if user && user.authenticate(params[:creds][:password])
            {token: JwtToken.encode({user_id: user.id})}
          else
            error! "Please check your email and password", 401
          end
        end

        desc "logout user"
        delete do
          if current_user
            {success: "#{current_user.name} has been logout successfully"}
          else
            error!({error: "Must be sign in first"})
          end

        end  
        
      end

    end
  end
end
