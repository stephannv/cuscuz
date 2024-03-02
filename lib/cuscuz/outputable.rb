require_relative "missing_output_error"

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
        outputs.each do |name, _|
          unless result.respond_to?(name)
            raise Cuscuz::MissingOutputError.new(self, name)
          end
        end
      end
    end
  end
end
