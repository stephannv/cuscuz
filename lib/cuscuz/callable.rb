require_relative "result_type_mismatch_error"

module Cuscuz
  module Callable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def [](**args)
        result = new(**args).call

        raise Cuscuz::ResultTypeMismatchError.new(self, result.class) unless result.is_a?(Cuscuz::Result)

        result
      end
    end
  end
end
