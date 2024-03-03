module Cuscuz
  class InputTypeMismatchError < StandardError
    def initialize(input_name, expected_types, given_type)
      super("The `#{input_name}` input must be of type #{expected_types} but received #{given_type}")
    end
  end

  class MissingOutputError < StandardError
    def initialize(class_name, output)
      super("The `#{class_name}` must output `#{output}` but it was missing")
    end
  end

  class OutputTypeMismatchError < StandardError
    def initialize(output, expected_type, given_type)
      super("The `#{output}` output must be of type #{expected_type} but it was #{given_type}")
    end
  end

  class ResultTypeMismatchError < StandardError
    def initialize(class_name, given_type)
      super(
        "The `#{class_name}` return type must be of type Cuscuz::Result (eg. Failure, Success) but it was #{given_type}"
      )
    end
  end
end
