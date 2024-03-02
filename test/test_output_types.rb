# frozen_string_literal: true

require "test_helper"

class TestOutputTypes < Minitest::Test
  class MyHash < Hash; end

  class OutputCorrectTypes
    include Cuscuz

    output :data, Hash
    output :month, Integer

    def call
      Failure[data: MyHash.new, month: 12]
    end
  end

  class OutputWrongTypes
    include Cuscuz

    output :data, Hash
    output :month, Integer

    def call
      Failure[data: {}, month: 4.4]
    end
  end

  def test_correct_output_types
    result = OutputCorrectTypes[]

    assert_kind_of Failure, result
    assert_equal result.data, MyHash.new
    assert_equal result.month, 12
  end

  def test_wrong_output_types
    error = assert_raises(Cuscuz::OutputTypeMismatchError) do
      OutputWrongTypes[]
    end

    assert_equal error.message, "The `month` output must be of type Integer but it was Float"
  end
end
