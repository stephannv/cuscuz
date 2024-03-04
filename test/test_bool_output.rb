# frozen_string_literal: true

require "test_helper"

class TestBoolOutput < Minitest::Test
  class ReturnBoolOutput
    include Cuscuz

    output :outline, Bool
    output :square, Bool

    def call
      Success[outline: true, square: false]
    end
  end

  class MismatchBoolOutputType
    include Cuscuz

    output :outline, Bool

    def call
      Success[outline: "yes"]
    end
  end

  def test_bool_output
    result = ReturnBoolOutput[]

    assert_kind_of Success, result

    assert_equal result.outline, true
    assert_equal result.outline?, true

    assert_equal result.square, false
    assert_equal result.square?, false
  end

  def test_mismatch_type
    error = assert_raises(Cuscuz::OutputTypeMismatchError) do
      MismatchBoolOutputType[]
    end

    assert_equal error.message, "The `outline` output must be of type TrueClass or FalseClass but it was String"
  end
end
