module Cuscuz
  module Callable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def [](**args)
        new(**args).__ccz_call__
      end
    end

    def call
    end

    def __ccz_call__
      result = call

      raise Cuscuz::ResultTypeMismatchError.new(self.class, result.class) unless result.is_a?(Cuscuz::Result)

      __ccz_validate_result_outputs__(result)

      result
    end
  end
end
