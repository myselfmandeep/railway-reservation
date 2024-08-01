module V1
  module Admin
    class Trains < Grape::API

      resource :trains do

        desc "return all trains" 
        get do
          present Train.all, with: V1::Entities::Trains
        end

        desc "create a train"
        params do
          requires :trains, type: Hash do
            requires :name,         type: String
            requires :working_days, type: Array[String]
            requires :coaches,      type: Array[Integer]
            requires :category,     type: String 
          end
        end

        post do
          train = Train.new(params[:trains])

          if train.save
            present train, with: V1::Entities::Trains
          else
            error!(train.get_object_errors)
          end
        end

        namespace ":id" do
          params do
            requires :id, type: Integer, desc: "train id"
          end
          
          before do
            @train = Train.find(params[:id])
          end

          get do
            present @train, with: V1::Entities::Trains
          end

          desc "update train resource"
          params do
            requires :trains, type: Hash do
              optional :name,         type: String
              optional :working_days, type: Array[String]
              optional :coaches,      type: Array[Integer]
              optional :category,     type: String 
            end
          end
          put do
            if @train.update(params[:trains])
              present @train, with: V1::Entities::Trains 
            else
              error!(@train.get_object_errors, 422)
            end
          end
          
          desc "delete train"
          delete do
            @train.destroy
              {message: "Train #{@train.name} has been deleted"}
          rescue 
            error!({error: "failed to destroy user"}, 403)
          end
          
        end
        
      end
    end 
  end
end
