module Cuscuz
  module Internals
    class Input
      attr_reader :name, :types

      def initialize(name, types)
        @name = name
        @types = Array(types)
      end

      def initializer_argument_definition
        "#{name}:"
      end

      def reader_method_definition
        <<-RUBY
          def #{reader_method_name}
            @__ccz_#{name}__
          end
        RUBY
      end

      def type_check_definition
        checks = types.map { |type| "#{name}.is_a?(#{type})" }.join(" || ")
        expected_types = types.join(" or ")

        <<~RUBY
          raise Cuscuz::InputTypeMismatchError.new(:#{name}, "#{expected_types}", #{name}.class) unless #{checks}
        RUBY
      end

      def assignment_definition
        "@__ccz_#{name}__ = #{name}"
      end

      private

      def reader_method_name = bool? ? "#{name}?" : name

      def bool? = (types == Bool)
    end
  end
end
