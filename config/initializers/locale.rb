  require 'i18n/backend/active_record'

  # todo add to readme
  ENV['translation_assoc_key'] = 'user_id'

  I18n::Backend::ActiveRecord.class_eval do
    def store_translations(locale, data, assoc_id, options = {})
      escape = options.fetch(:escape, true)
      flatten_translations(locale, data, escape, false).each do |key, value|
        Translation.locale(locale).lookup(expand_keys(key)).delete_all
        Translation.create(:locale => locale.to_s, :key => key.to_s, :value => value, ENV['translation_assoc_key'].to_sym => assoc_id )
      end
    end
  end

  I18n::Backend::ActiveRecord::Translation.class_eval do
    class << self
      def lookup(keys, *separator)
        column_name = connection.quote_column_name('key')
        keys = Array(keys).map! { |key| key.to_s }

        unless separator.empty?
          warn "[DEPRECATION] Giving a separator to Translation.lookup is deprecated. " <<
            "You can change the internal separator by overwriting FLATTEN_SEPARATOR."
        end

        namespace = "#{keys.last}#{I18n::Backend::Flatten::FLATTEN_SEPARATOR}%"

        assoc_key = ENV['translation_assoc_key']
        assoc_id = ENV[assoc_key]
        assoc_condition = ''
        assoc_condition = "\"#{table_name}\".\"#{assoc_key}\" = #{assoc_id} AND " if assoc_key and assoc_id
        scoped(:conditions => ["#{assoc_condition} #{column_name} IN (?) OR #{column_name} LIKE ?", keys, namespace])

      end
    end
  end

  TRANSLATIONS_STORE = I18n::Backend::ActiveRecord.new

  I18n.backend = I18n::Backend::Chain.new(TRANSLATIONS_STORE, I18n.backend)
