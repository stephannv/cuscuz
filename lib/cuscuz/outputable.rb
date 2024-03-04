require_relative "internals/output"
require_relative "internals/result_validator"

module Cuscuz
  module Outputable
    def self.included(base)
      base.extend(ClassMethods)
      base.define_method :__ccz_validate_result_outputs__, ->(result) {}
    end

    module ClassMethods
      def output(name, type)
        add_output(name, type)

        define_validate_result
      end

      private

      def add_output(name, type)
        outputs[name] = Internals::Output.new(name, type)
      end

      def outputs
        @outputs ||= {}
      end

      def define_validate_result
        remove_method :__ccz_validate_result_outputs__

        result_validator = Internals::ResultValidator.new(outputs)

        class_eval result_validator.definition, __FILE__, __LINE__
      end
    end
  end
end
