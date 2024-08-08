module V1
  class Users < Grape::API

    helpers V1::Helpers::CommonParams
    
    resource :users do
      
      desc "List of all users"
      get do
        present User.all, with: V1::Entities::Users
      end

      desc "Create user record"
      params do
        requires :users, type: Hash do
          requires :name,      type: String
          requires :email,     type: String
          requires :password,  type: String
          requires :gender,    type: String
          requires :user_name, type: String
        end
      end
      
      post do
        user  = User.new(params[:users])
        
        if user.save
          { token: JwtToken.encode({user_id: user.id}) }
        else
          error!({ errors: user.errors.full_messages }, 422)
        end
      end

      namespace ":id" do
        params do
          requires :id, type: Integer, desc: "user id"
        end
        
        before do
          @user = User.find(params[:id])
        end
        
        get do
          present(@user, with: V1::Entities::Users)
        end
          
        desc "Perform full update"
        params do
          requires :users, type: Hash do
            optional :name,      type: String, allow_blank: false
            optional :email,     type: String, allow_blank: false
            optional :password,  type: String, allow_blank: false
            optional :gender,    type: String, allow_blank: false
            optional :user_name, type: String, allow_blank: false
          end
        end

        put do
          if  @user.update(params[:users])
            present(@user, with: V1::Entities::Users)
          else
            error!({errors: @user.errors.full_messages}, 422)
          end
        end

        desc "destroy user"
        delete do
          @user.destroy
          { message: "user #{@user.name} has been deleted" }
          rescue
            error!({ error: "Failed to delete the user" }, 405)
        end
      end

      desc "search users"
      params do
        use :searchable 
      end 
      get :search do
        users = User.where("name ILIKE :search OR email ILIKE :search OR user_name ILIKE :search", search: "%#{search_query}%")
        present users, with: V1::Entities::Users
      end

    end
  end
end
