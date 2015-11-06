class ActiveRecord::Base
  class << self
    def h label
      self.human_attribute_name label
    end

    def human_name
      self.model_name.human
    end
  end
end