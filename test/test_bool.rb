# frozen_string_literal: true

require "test_helper"

class TestBool < Minitest::Test
  class DoSomething
    include Cuscuz

    input :admin, Bool

    def call
      if admin?
        Success[]
      else
        Failure[]
      end
    end
  end

  def test_true
    result = DoSomething[admin: true]

    assert_kind_of Success, result
  end

  def test_false
    result = DoSomething[admin: false]

    assert_kind_of Failure, result
  end

  def test_mismatch_type
    error = assert_raises(Cuscuz::InputTypeMismatchError) do
      DoSomething[admin: "true"]
    end

    assert_equal error.message, "The `admin` input must be of type TrueClass or FalseClass but received String"
  end
end
