require_relative "result"

module Cuscuz
  class Failure < Result
    def success? = false

    def failure? = true
  end
end

Failure = Cuscuz::Failure
