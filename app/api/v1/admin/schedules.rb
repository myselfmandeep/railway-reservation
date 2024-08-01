module V1
  module Admin
    class Schedules < Grape::API

      namespace :admin do
        resource :schedules do
          
          desc "return all schedules"
          get do
            present Schedule.all, with: V1::Entities::Schedules
          end
          
          desc "create a new schedule"
          params do
            requires :schedules, type: Hash do
              requires :train_id,               type: Integer, desc: "schedule for which train"
              requires :source_station_id,      type: Integer, desc: "first station"
              requires :destination_station_id, type: Integer, desc: "last station"
              requires :distance,               type: Float,   desc: "total distance"
              requires :arrived_at,             type: String,  desc: "start time"
              requires :departure_at,           type: String,  desc: "end time"
            end
          end
          post do
            schedule = Schedule.new(params[:schedules])

            if schedule.save
              present schedule, with: V1::Entities::Schedules
            else
              error!(schedule.get_object_errors, 422)
            end
          end

          namespace ":id" do

            before do
              @schedule = Schedule.find(params[:id])
            end
            
            params do
              requires :id, type: Integer, desc: "schedule id"
            end

            desc "get schedule"
            get do
              present @schedule, with: V1::Entities::Schedules
            end

            desc "update schedule record"
            params do
              requires :schedules, type: Hash do
                requires :train_id,               type: Integer, desc: "schedule for which train"
                requires :source_station_id,      type: Integer, desc: "first station"
                requires :destination_station_id, type: Integer, desc: "last station"
                optional :distance,               type: Float,   desc: "total distance"
                optional :arrived_at,             type: String,  desc: "start time"
                optional :departure_at,           type: String,  desc: "end time"
              end
            end
            put do
              if @schedule.update(params[:schedules])
                {message: "Schedule has been updated successfully"}
              else
                error!(@schedule.get_object_errors, 422)
              end
            end

            desc "destroy the schedule record"
            delete do
              if @schedule.destroy
                {message: "Schedule has been deleted"}
              end
            end

          end
        end
      end
    end
  end
end
