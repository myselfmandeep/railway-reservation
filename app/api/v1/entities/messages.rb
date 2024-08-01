module V1
  module Entities
    class Messages < Base
      expose :body
      expose :sender, with: Users
    end
  end
end