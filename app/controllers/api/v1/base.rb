module API
  module V1
    class Base < Grape::API
      mount API::V1::Market
      mount API::V1::Discussion
    end
  end
end
