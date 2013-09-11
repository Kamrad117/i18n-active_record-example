class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter { |c| c.set_translations_owner_id(current_user.id) }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def set_translations_owner_id(id)
    assoc_foreign_key = ENV['translation_assoc_key']
    ENV[assoc_foreign_key] = id.to_s
  end

  private

  def set_locale
    I18n.locale = params[:locale]
  end

end
