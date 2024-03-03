module Cuscuz
  module Inputable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def input(name, types)
        inputs[name] = {types: Array(types)}

        define_reader(name, types)

        define_initializer
      end

      private

      def inputs
        @inputs ||= {}
      end

      def define_reader(name, types)
        method_name = (types == Bool) ? "#{name}?" : name

        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{method_name}
            @__ccz_#{name}__
          end
        RUBY
      end

      def define_initializer
        remove_method :initialize if method_defined?(:initialize)

        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def initialize(#{input_arguments})
            #{input_initializers}
          end
        RUBY
      end

      def input_arguments
        inputs.map { |name, _| "#{name}:" }.join(",")
      end

      def input_initializers
        inputs.map do |name, options|
          <<~RUBY
            #{input_type_check(name, options[:types])}
            @__ccz_#{name}__ = #{name}
          RUBY
        end.join("\n")
      end

      def input_type_check(name, types)
        checks = types.map { |type| "#{name}.kind_of?(#{type})" }.join(" || ")
        expected_classes = types.join(" or ")

        <<~RUBY
          raise Cuscuz::InputTypeMismatchError.new(:#{name}, "#{expected_classes}", #{name}.class) unless #{checks}
        RUBY
      end
    end
  end
end
