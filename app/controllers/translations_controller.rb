class TranslationsController < ApplicationController
  def index
    @translations = I18n::Backend::ActiveRecord::Translation.locale(:en).where(user_id: current_user.id)
  end

  def create
    TRANSLATIONS_STORE.store_translations(params[:locale], {params[:key] => params[:value].strip}, current_user.id)
    redirect_to translations_url, :notice => "Added translations"
  end
end
