require 'i18n/backend/active_record'

ENV['translation_assoc_key'] = 'user_id'
TRANSLATIONS_STORE = I18n::Backend::ActiveRecord.new
I18n.backend = I18n::Backend::Chain.new(TRANSLATIONS_STORE, I18n.backend)
