module V1
  module Entities
    class Payments < Base
      expose :paid_amount
      expose :transaction_id
    end
  end
end
