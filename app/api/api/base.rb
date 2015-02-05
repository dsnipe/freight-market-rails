module API
  class Base < Grape::API
    prefix 'api'
    format :json
    logger Rails.logger
    error_formatter :json, API::ErrorFormatter
    helpers API::Helpers

    before do
      error!('Unauthorized', 401) unless authenticated
      Rails.logger.info "Request Body: #{request.body.read}"
    end

    mount API::V1::Base
  end

  # Base = Rack::Builder.new do
  #   use API::Logger
  #   run API::Dispatch
  # end
end
