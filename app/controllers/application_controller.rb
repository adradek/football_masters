class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :log_visit

  private

  def pundit_user
    current_user
  end

  def user_not_authorized
    redirect_to root_path, alert: "Это НЕДОПУСТИИИИИМО!!!! (c) 🍋"
  end

  def log_visit
    return unless Rails.env.production?
    return unless request.get?
    return unless request.format.html?

    Visit.create(user_id: current_user&.id, ip: request.remote_ip, controller: controller_name, action: action_name)
  rescue => e
    Rails.logger.error "Error logging visit: #{e.class} => message: #{e.message}"
  end
end
