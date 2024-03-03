# frozen_string_literal: true

require_relative "cuscuz/callable"
require_relative "cuscuz/inputable"
require_relative "cuscuz/outputable"
require_relative "cuscuz/errors"

require_relative "cuscuz/failure"
require_relative "cuscuz/success"

module Cuscuz
  Bool = [TrueClass, FalseClass].freeze  # standard:disable Naming/ConstantName

  def self.included(base)
    base.include(Cuscuz::Callable)
    base.include(Cuscuz::Inputable)
    base.include(Cuscuz::Outputable)
  end
end
