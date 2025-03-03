# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  before_action :authenticate_user

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    Rails.logger.info "Decoded User: #{@current_user.inspect}" # Debugging line

    context = {
      current_user: @current_user
    }

    result = TaskManageApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token.present?

    decoded_token = JwToken.decode(token)
    if decoded_token && decoded_token["user_id"]
      @current_user = User.find_by(id: decoded_token["user_id"])
      
      if @current_user.nil?
        Rails.logger.error "User not found for ID: #{decoded_token["user_id"]}"
      end
    end
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Error: #{e.message}"
    @current_user = nil
  end

  def current_user
    @current_user
  end

  def ensure_hash(variables)
    case variables
    when String
      JSON.parse(variables) rescue {}
    when Hash
      variables
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables}"
    end
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  
end
