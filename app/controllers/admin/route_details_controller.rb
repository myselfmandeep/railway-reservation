module Admin  
  class RouteDetailsController < Admin::ApplicationController

    def show
      @train = Train.find(params[:train_id])
      @routes = @train.schedules
      
      respond_to do |format|
        format.js
      end
    end
  end
end