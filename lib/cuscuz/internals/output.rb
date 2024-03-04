module Cuscuz
  module Internals
    class Output
      attr_reader :name, :types

      def initialize(name, types)
        @name = name
        @types = Array(types)
      end

      def presence_check_definition
        <<~RUBY
          raise Cuscuz::MissingOutputError.new(self.class, :#{name}) unless result.respond_to?(:#{name})
        RUBY
      end

      def type_check_definition
        variable_name = "__#{name}_value__"
        checks = types.map { |type| "#{variable_name}.is_a?(#{type})" }.join(" || ")
        expected_types = types.join(" or ")

        <<~RUBY
          #{variable_name} = result.#{name}
          unless #{checks}
            raise Cuscuz::OutputTypeMismatchError.new(:#{name}, "#{expected_types}", #{variable_name}.class)
          end
        RUBY
      end
    end
  end
end
