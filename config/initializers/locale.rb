  require 'i18n/backend/active_record'

  I18n::Backend::ActiveRecord.class_eval do
    def store_translations(locale, data, user_id, options = {})
      escape = options.fetch(:escape, true)
      flatten_translations(locale, data, escape, false).each do |key, value|
        Translation.locale(locale).lookup(expand_keys(key)).delete_all
        Translation.create(:locale => locale.to_s, :key => key.to_s, :value => value, :user_id => user_id )
      end
    end
  end

  I18n.backend = I18n::Backend::ActiveRecord.new

  # require 'i18n/backend/active_record'
  # TRANSLATIONS_STORE = I18n::Backend::ActiveRecord.new

  # I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
  # I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Flatten)
  # I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
  # I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

  # I18n.backend = I18n::Backend::Chain.new(I18n::Backend::Simple.new, TRANSLATIONS_STORE)
