module V1
  module Admin
    class Base < Grape::API

      before do
        error!({error: "you don't have a admin role"}, 405) unless current_user.is_admin?
      end

      mount Roles
      mount Schedules
      mount Stations
      mount Trains
      mount Tiers

    end
  end
end
