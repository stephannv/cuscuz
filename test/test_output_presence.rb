# frozen_string_literal: true

require "test_helper"

class TestOutputPresence < Minitest::Test
  class ReturnRequiredOutput
    include Cuscuz

    output :value, Integer

    def call
      Success[value: 4]
    end
  end

  class MissRequiredOutput
    include Cuscuz

    output :value, Integer

    def call
      Success[other: 5]
    end
  end

  def test_correct_output
    result = ReturnRequiredOutput[]

    assert_kind_of Success, result
    assert_equal result.value, 4
  end

  def test_missing_output
    error = assert_raises(Cuscuz::MissingOutputError) do
      MissRequiredOutput[]
    end

    assert_equal error.message,
      "The `TestOutputPresence::MissRequiredOutput` must output `value` but it was missing"
  end
end
