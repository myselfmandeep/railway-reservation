module V1
  class Bookings < Grape::API

    helpers do
      def booking_params
        declared(params, include_blank: false)
      end
    end
      

    resource :bookings do
      desc "booking of user"
      get do
        policy = BookingPolicy.new(current_user)
        present policy.list, with: V1::Entities::Bookings
      end

      desc "create booking record"
      params do
        requires :bookings, type: Hash do
          requires :schedule_id, type: Integer
          requires :payment_id,  type: String
          requires :amount,      type: Float
          requires :date,        type: String
        end
          
        requires :tickets, type: Array[Hash]
        requires :tier,    type: Integer
      end
      
      post do
        @booking = BookingService.new(params, current_user).call

        if @booking
          present @booking, with: V1::Entities::Bookings
        else
          error! "Validation Error", 422
        end
      end
      
    end

  end
end
