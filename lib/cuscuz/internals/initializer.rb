module Cuscuz
  module Internals
    class Initializer
      def initialize(inputs)
        @inputs = inputs
      end

      def definition
        <<-RUBY
          def initialize(#{arguments})
            #{type_checks}
            #{assignments}
          end
        RUBY
      end

      private

      attr_reader :inputs

      def arguments = inputs.values.map { |input| input.initializer_argument_definition }.join(",")

      def type_checks = inputs.values.map { |input| input.type_check_definition }.join("\n")

      def assignments = inputs.values.map { |input| input.assignment_definition }.join("\n")
    end
  end
end
