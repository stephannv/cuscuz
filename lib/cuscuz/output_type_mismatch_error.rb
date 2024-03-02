module Cuscuz
  class OutputTypeMismatchError < StandardError
    def initialize(output, expected_type, given_type)
      super("The `#{output}` output must be of type #{expected_type} but it was #{given_type}")
    end
  end
end
