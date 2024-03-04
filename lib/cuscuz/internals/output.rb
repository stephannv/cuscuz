module Cuscuz
  module Internals
    class Output
      attr_reader :name, :type

      def initialize(name, type)
        @name = name
        @type = type
      end

      def presence_check_definition
        <<~RUBY
          raise Cuscuz::MissingOutputError.new(self.class, :#{name}) unless result.respond_to?(:#{name})
        RUBY
      end

      def type_check_definition
        output_value_var = "#{name}_output_value"
        <<~RUBY
          #{output_value_var} = result.#{name}
          unless #{output_value_var}.kind_of?(#{type})
            raise Cuscuz::OutputTypeMismatchError.new(:#{name}, #{type}, #{output_value_var}.class)
          end
        RUBY
      end
    end
  end
end
