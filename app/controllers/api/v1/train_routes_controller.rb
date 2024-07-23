module Api
  module V1
    class TrainRoutesController < Api::V1::ApplicationController

      def index
        routes=  Schedule.where(train_id: params[:trainId])
        render json: routes, each_serializer: TrainRoutesSerializer
      end

      def booking_price
        fare = Schedule.find(params[:routeId])
        # render json: fare.distance * Coach::PRICES[(params[:coach_class])]
        render json: fare.distance * Tier.find(params[:coach_class]).price_per_km
      end

      def password_reset_token
        user = User.find_by(email: params[:email])
        render json: {token: user&.reset_token}
      end

      def pnr_details
        booking = Booking.find_by(pnr_number: params[:pnrNumber])
        render json: booking
      end

      def available_seats
        route = Schedule.find(params[:route_id])
        tier  = Tier.find(params[:category])
        # aval_seats = Booking.available_seats(route, params[:date], params[:category])
        # binding.pry
        aval_seats = Booking.available_seats(route, params[:date], tier)

        render json: {
                      unreserved_seats: aval_seats,
                      availability: aval_seats > 0 ? "available" : "not available"
                    }
      end
      
    end
  end
end
