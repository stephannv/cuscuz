# frozen_string_literal: true

require "test_helper"

class TestResultType < Minitest::Test
  class AuthorizationFailure < Failure; end

  class ReturnResultSubclass
    include Cuscuz

    def call
      AuthorizationFailure[]
    end
  end

  class ReturnWrongResult
    include Cuscuz

    def call
      {success: true}
    end
  end

  def test_result_subclass
    result = ReturnResultSubclass[]

    assert_kind_of AuthorizationFailure, result
  end


  def test_wrong_result_type
    error = assert_raises(Cuscuz::ResultTypeMismatchError) do
      ReturnWrongResult[]
    end

    assert_equal error.message,
      "The `TestResultType::ReturnWrongResult` return type must be of type Cuscuz::Result (eg. Failure, Success) but it was Hash"
  end
end
