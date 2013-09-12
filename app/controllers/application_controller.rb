class ApplicationController < ActionController::Base
  include I18n::Backend::ControllerHelpers
  protect_from_forgery

  before_filter { |c| c.set_translations_owner_id(user_id) }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def user_id
    if defined?(current_user) && !current_user.nil?
      current_user.id
    else
      nil
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale]
  end

end
