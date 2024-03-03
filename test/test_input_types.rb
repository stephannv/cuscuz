# frozen_string_literal: true

require "test_helper"

class TestInputTypes < Minitest::Test
  class MyHash < Hash; end

  class DoSomething
    include Cuscuz

    input :data, [Hash, Array]
    input :month, Integer

    def call
      Success[]
    end
  end

  def test_success
    assert_kind_of Success, DoSomething[data: MyHash.new, month: 3]
  end

  def test_multiple_types
    assert_kind_of Success, DoSomething[data: [:a, :b, :c], month: 5]
  end

  def test_failure
    error = assert_raises(Cuscuz::InputTypeMismatchError) do
      DoSomething[data: {}, month: 4.4]
    end

    assert_equal error.message, "The `month` input must be of type Integer but received Float"
  end

  def test_multiple_types_failure
    error = assert_raises(Cuscuz::InputTypeMismatchError) do
      DoSomething[data: "some-data", month: 1]
    end

    assert_equal error.message, "The `data` input must be of type Hash or Array but received String"
  end
end
