
class Base < Grape::API
  
  mount V1::Base => "#{::V1::Base::VERSION}"

  get "/" do
    { message: "Book your ticket today" }
  end

  get "home" do 
    { message: "Make booking for your upcoming traveling plans" }
  end

  get :about do
    {message: "We provide you a booking platforms for railway reservation"}
  end
  
end
