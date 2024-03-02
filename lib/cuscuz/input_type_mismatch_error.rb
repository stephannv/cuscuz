module Cuscuz
  class InputTypeMismatchError < StandardError
    def initialize(input_name, expected_type, given_type)
      @input_name = input_name
      @expected_type = expected_type
      @given_type = given_type

      super("The `#{@input_name}` input must be of type #{@expected_type} but received #{@given_type}")
    end
  end
end
