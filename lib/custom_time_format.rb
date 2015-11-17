module CustomTimeFormat
  extend ActiveSupport::Concern

  def default_format
    I18n.l self
  end

  def time_format format
    I18n.l self, format: format
  end
end
Time.include CustomTimeFormat