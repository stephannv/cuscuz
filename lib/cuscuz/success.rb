require_relative "result"

module Cuscuz
  class Success < Result
    def success? = true

    def failure? = false
  end
end

Success = Cuscuz::Success
