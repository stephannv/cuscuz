module Cuscuz
  module Callable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def [](**args)
        result = new(**args).call

        raise Cuscuz::ResultTypeMismatchError.new(self, result.class) unless result.is_a?(Cuscuz::Result)

        validate_outputs(result)

        result
      end
    end
  end
end
