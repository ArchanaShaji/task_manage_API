class ApplicationController < ActionController::API
	rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_error

	private

	def handle_validation_error(exception)
	  render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
	end
end
