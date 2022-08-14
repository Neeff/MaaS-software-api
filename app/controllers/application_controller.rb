class ApplicationController < ActionController::API
  before_action :cors_preflight_check
  before_action :add_allow_credentials_headers
  after_action :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']  = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age']       = '1728000'
  end

  def cors_preflight_check
    return unless request.method == 'OPTIONS'

    headers['Access-Control-Allow-Origin']  = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
    headers['Access-Control-Max-Age']       = '1728000'
    render text: '', content_type: 'plain/text'
  end

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
    response.headers['Access-Control-Request-Method'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def render_rescue(exception)
    Rails.logger.info { "ERROR: #{exception.message}\nBUGTRACE#{exception.backtrace[0]}" }
    render json: { message: exception.message, state: :error }, status: :bad_request
  end
end
