module Cuscuz
  class MissingOutputError < StandardError
    def initialize(class_name, output)
      super("The `#{class_name}` must output `#{output}` but it was missing")
    end
  end
end
