class TranslationsController < ApplicationController
  def index
    @translations = I18n::Backend::ActiveRecord::Translation.locale(:en).all
  end

  def create
    I18n.backend.store_translations(params[:locale], {params[:key] => params[:value]}, current_user.id, :escape => false)
    redirect_to translations_url, :notice => "Added translations"
  end
end
