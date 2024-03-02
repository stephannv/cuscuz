module Cuscuz
  class Result
    def self.[](**kwargs)
      instance = new

      kwargs.each do |k, v|
        instance.define_singleton_method(k) { v }
      end

      instance
    end
  end
end
