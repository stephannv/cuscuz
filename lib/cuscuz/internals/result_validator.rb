module Cuscuz
  module Internals
    class ResultValidator
      def initialize(outputs)
        @outputs = outputs
      end

      def definition
        <<~RUBY
          def __ccz_validate_result_outputs__(result)
            #{presence_checks}
            #{type_checks}
          end
        RUBY
      end

      private

      attr_reader :outputs

      def presence_checks = outputs.values.map { |output| output.presence_check_definition }.join("\n")

      def type_checks = outputs.values.map { |output| output.type_check_definition }.join("\n")
    end
  end
end
