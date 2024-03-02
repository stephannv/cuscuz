require_relative "missing_output_error"
require_relative "output_type_mismatch_error"

module Cuscuz
  module Outputable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def output(name, type)
        outputs[name] = {type: type}
      end

      private

      def outputs
        @outputs ||= {}
      end

      def validate_outputs(result)
        outputs.each do |name, options|
          unless result.respond_to?(name)
            raise Cuscuz::MissingOutputError.new(self, name)
          end

          value = result.public_send(name)

          unless value.is_a?(options[:type])
            raise Cuscuz::OutputTypeMismatchError.new(name, options[:type], value.class)
          end
        end
      end
    end
  end
end
