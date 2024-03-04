require_relative "internals/initializer"
require_relative "internals/input"

module Cuscuz
  module Inputable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def input(name, types)
        add_input(name, types)

        define_initializer
      end

      private

      def add_input(name, types)
        input = Internals::Input.new(name, types)

        inputs[name] = input

        class_eval input.reader_method_definition, __FILE__, __LINE__
      end

      def inputs
        @inputs ||= {}
      end

      def define_initializer
        remove_method(:initialize) if method_defined?(:initialize)

        initializer = Internals::Initializer.new(inputs)

        silence_warnings { class_eval(initializer.definition, __FILE__, __LINE__) }
      end

      def silence_warnings(&block)
        old_verbose, $VERBOSE = $VERBOSE, nil
        block.call
      ensure
        $VERBOSE = old_verbose
      end
    end
  end
end
