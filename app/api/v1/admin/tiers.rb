module V1
  module Admin
    class Tiers < Grape::API

      resource :tiers do
        desc "get list of all tiers"
        get do
          req  = Faraday.get("#{ENV['WEBHOOK_URL']}/api/v1/webhooks")

          body = JSON.parse(req.body)
          code = req.status

          if code == 200
            body
          else
            error!(body, code)
          end
          
        end
      end
      
    end
  end
end