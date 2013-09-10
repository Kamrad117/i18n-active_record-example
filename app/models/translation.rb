class Translation < I18n::Backend::ActiveRecord::Translation
  attr_accessible :locale, :key, :value, :interpolations, :is_proc, :user_id
  belongs_to :user
end
