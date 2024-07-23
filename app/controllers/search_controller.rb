class SearchController < ApplicationController

  def new
    @source       = search_params[:source]
    @destination  = search_params[:destination]
    # @routes       = TrainRoute.get_route(@source, @destination)
    @routes       = Schedule.get_route(@source, @destination)
  end

  private

  def search_params
    params.require(:search_query).permit(:source, :destination)
  end

end