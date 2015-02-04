module API
  class Base < Grape::API
    prefix 'api'
    error_formatter :json, API::ErrorFormatter
    mount API::V1::Base
  end

  # Base = Rack::Builder.new do
  #   use API::Logger
  #   run API::Dispatch
  # end
end
