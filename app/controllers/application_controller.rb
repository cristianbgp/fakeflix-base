class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit

  before_action :require_login
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def render_unauthorized(message)
    errors = { errors: { message: message } }
    render json: errors, status: :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    render json: { error: 'Unnecessary permissions' }, status: 403
  end
end
