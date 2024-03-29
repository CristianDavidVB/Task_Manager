module ExceptionHandler
  extend ActiveSupport::Concern

    class MissingToken < StandardError
    end

    class InvalidToken < StandardError
    end

    included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ExceptionHandler::AuthenticationError, with: :record_unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :record_unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :record_unprocessable_entity
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def record_not_found(e)
      render json: {message: e.message}, status: :not_found
    end

    def record_unauthorized_request(e)
      render json {message: e.message}, status: :unauthorized
    end

    def record_unprocessable_entity(e)
      render json: {message: e.message}, status: :unprocessable_entity
    end

    def user_not_authorized
      render json: {message: "you are not authorized to perfom this action"
      }, status: :unauthorized
    end
  end
end
