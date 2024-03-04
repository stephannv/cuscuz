module Cuscuz
  class Result
    def self.[](**outputs)
      instance = new

      define_reader_methods(instance, outputs)

      instance
    end

    def self.define_reader_methods(instance, outputs)
      outputs.each do |name, value|
        instance.define_singleton_method(name) { value }
        instance.define_singleton_method(:"#{name}?") { value } if Bool.any? { |type| value.is_a?(type) }
      end
    end
  end
end
