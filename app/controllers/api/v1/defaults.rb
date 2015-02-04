module API
  module V1

    module Defaults
      # We're in Rails world
      extend ActiveSupport::Concern

      included do
        # common Grape settings
        version 'v1', using: :header, vendor: :eyjafjallajokull
        format :json
        logger Rails.logger

        # global handler for simple not found case
        rescue_from Mongoid::Errors::DocumentNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        # global exception handler, used for error notifications
        rescue_from :all do |e|
          if Rails.env.development?
            raise e
          else
            error_response(message: "Internal server error", status: 500)
          end
        end

        # HTTP based authentication
        before do
          error!('Unauthorized', 401) unless authenticated
          # headers['Authorization'] == "some token"
          Rails.logger.info "Request Body: #{request.body.read}"
        end


        helpers do
          def current_user
            Customer::User.find_by_email(params[:email]).cache
          end

          def authenticated
            current_user && current_user.valid_password?(params[:password])
          end
        end
      end

    end
  end
end
