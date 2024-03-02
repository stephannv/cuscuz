module Cuscuz
  class ResultTypeMismatchError < StandardError
    def initialize(class_name, given_type)
      super(
        "The `#{class_name}` return type must be of type Cuscuz::Result (eg. Failure, Success) but it was #{given_type}"
      )
    end
  end
end
