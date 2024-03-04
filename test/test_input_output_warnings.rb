# frozen_string_literal: true

require "test_helper"

class TestInputOutputWarnings < Minitest::Test
  def test_no_warnings
    assert_silent do
      Class.new do
        include Cuscuz

        input :a, String
        input :b, Integer

        output :c, Hash
        output :d, Array

        def call
        end
      end
    end
  end
end
