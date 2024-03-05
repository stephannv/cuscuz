module Cuscuz
  class Result
    def initialize(**outputs)
      @__outputs__ = outputs
      __define_reader_methods__
    end

    class << self
      def [](**outputs)
        new(**outputs)
      end
    end

    def __define_reader_methods__
      @__outputs__.each do |name, value|
        define_singleton_method(name) { value }
        define_singleton_method(:"#{name}?") { value } if Bool.any? { |type| value.is_a?(type) }
      end
    end

    def deconstruct_keys(keys)
      keys ? @__outputs__.slice(*keys) : @__outputs__
    end
  end
end
