module API
  module V1
    class Base < Grape::API
      version 'v1', using: :header, vendor: :eyjafjallajokull

      rescue_from Mongoid::Errors::DocumentNotFound do |e|
        error_response(message: e.message, status: 404)
      end

      # rescue_from Grape::Exceptions::ValidationErrors do |e|
      #   # Special format for validation errors
      # end

      # global exception handler, used for error notifications
      rescue_from :all do |e|
        if Rails.env.development?
          raise e
        else
          Rails.logger.error("\n\n#{e.class.name} - #{e.message}:\n   " +
            Rails.backtrace_cleaner.clean(e.backtrace).join("\n   "))
          error_response(e)
        end
      end

      mount ::API::V1::Market
      mount ::API::V1::Discussion
    end
  end
end
