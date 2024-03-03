# frozen_string_literal: true

require "test_helper"

class TestSuccessAndFailure < Minitest::Test
  class ReturnSuccess
    include Cuscuz

    def call
      Success[]
    end
  end

  class ReturnFailure
    include Cuscuz

    def call
      Failure[]
    end
  end

  def test_success
    result = ReturnSuccess[]

    assert_kind_of Success, result
    assert_equal result.success?, true
    assert_equal result.failure?, false
  end

  def test_failure
    result = ReturnFailure[]

    assert_kind_of Failure, result
    assert_equal result.success?, false
    assert_equal result.failure?, true
  end
end
