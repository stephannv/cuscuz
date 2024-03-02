# frozen_string_literal: true

require "test_helper"

class TestBasic < Minitest::Test
  class User
    attr_reader :name, :email

    def initialize(name:, email:)
      @name = name
      @email = email
    end
  end

  class CreateUser
    include Cuscuz

    input :attributes, Hash

    output :user, User

    def call
      user = User.new(**attributes)

      if user.name && user.email
        Success[user: user]
      else
        Failure[reason: :invalid_record, user: user]
      end
    end
  end

  def test_success
    result = CreateUser[attributes: {name: "Stephann", email: "stephann@example.com"}]

    assert_kind_of Success, result
    assert_equal result.user.name, "Stephann"
    assert_equal result.user.email, "stephann@example.com"
  end

  def test_failure
    result = CreateUser[attributes: {name: nil, email: "stephann@example.com"}]

    assert_kind_of Failure, result
    assert_equal result.reason, :invalid_record
    assert_nil result.user.name
    assert_equal result.user.email, "stephann@example.com"
  end
end
