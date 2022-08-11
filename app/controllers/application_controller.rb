class ApplicationController < ActionController::API
  def render_rescue(exception)
    Rails.logger.info { "ERROR: #{exception.message}\nBUGTRACE#{exception.backtrace[0]}" }
    render json: { message: exception.message, state: :error }, status: :bad_request
  end
end
