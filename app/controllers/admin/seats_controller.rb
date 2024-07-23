module Admin
  class SeatsController < ApplicationController
    before_action :set_seat, only: %i[edit update destroy]
    
    def index
      @coach = Coach.find_by(id: params[:coach_id])
      @seats = @coach&.seats || []

      respond_to do |format|
        format.js

        format.html do
          @seats = Seat.order(updated_at: :desc).paginate(per_page: 100, page: params[:page])
        end
      end
    end

    def new
      @seat = Seat.new
      
      respond_to do |format|
        format.js do
          @coach      = params[:seat][:coach_id]
          no_of_seats = params[:seat][:total_seats].to_i
          integer     = if no_of_seats.positive?
                          no_of_seats > 150 ? 150 : no_of_seats
                        else
                          1
                        end

          integer.to_i.times do
            @seat.new_seats << Seat.new
          end
        end

        format.html
      end
    end

    def create
      begin
        Seat.transaction do
          @coach = Coach.find(params[:seat][:coach_id])
          seats  = @coach.seats.create!(permit_multiple_params)
        end
        
        redirect_to admin_seats_path, notice: "Successfully added seats..."
      rescue => e
        redirect_to admin_seats_path, notice: e.record.errors.full_messages
      end
    end

    def edit
    end

    def update
      if @seat.update(seat_params)
        redirect_to admin_seats_path(coach_id: @seat.coach.id), notice: "updated seat no. #{@seat.number} of coach #{@seat.coach.name}"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @seat.destroy

      redirect_to admin_seats_path, notice: "Seat no. #{@seat.number} of #{@seat.coach.name} has been deleted"
    end
    
    private
  
    def seat_params
      params.require(:seat).permit(:number, :berth, :position, :coach_id)
    end

    def permit_multiple_params
      params.require(:seat).require(:seats).values.map do |seat|
        seat.permit(:number, :berth, :position)
      end
    end

    def set_seat
      @seat = Seat.find(params[:id])
    end
    
  end
end