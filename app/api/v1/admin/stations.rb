module V1
  module Admin
    class Stations < Grape::API

      resource :stations do

        desc "return all users"
        get do
          stations = Station.all
          
          present stations, with: V1::Entities::Stations
        end

        desc "create station record"
        params do
          requires :stations, type: Hash do
            requires :name,     type: String
            requires :city,     type: String
            requires :location, type: String
          end
        end
        post do
          station = Station.new(params[:stations])
          if station.save
            present station, with: V1::Entities::Stations
          else
            error!(station.get_object_errors, 422)
          end
        end
        
        namespace ":id" do
          params do
            requires :id, type: Integer, desc: "station id"
          end
          
          before do
            @station = Station.find(params[:id])
          end

          desc "get station with id"
          get do
            present @station, with: V1::Entities::Stations
          end

          desc "update station record"
          params do
            requires :stations, type: Hash do
              optional :name,     type: String
              optional :city,     type: String
              optional :location, type: String
            end
          end

          put do
            if @station.update(params[:stations])
              present @station, with: V1::Entities::Stations
            else
              error!(@station.get_object_errors, 422)
            end
          end

          desc "delete station"
          delete do
            if @station.destroy
              present @station, with: V1::Entities::Stations
            else
              error!(@station.get_object_errors, 422)
            end
          end
          
        end
        
      end        
    end
  end
end
