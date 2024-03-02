module Cuscuz
  module Inputable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def input(name, type)
        inputs[name] = {type:}

        define_reader(name)

        define_initializer
      end

      private

      def inputs
        @inputs ||= {}
      end

      def define_reader(name)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{name}
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
            #{name} => #{options[:type]}
            @__ccz_#{name}__ = #{name}
          RUBY
        end.join("\n")
      end
    end
  end
end
