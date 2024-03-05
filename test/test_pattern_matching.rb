# frozen_string_literal: true

require "test_helper"

class TestPatternMatching < Minitest::Test
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
      elsif user.name.nil?
        Failure[reason: :invalid_name, user: user]
      else
        Failure[reason: :invalid_email, user: user]
      end
    end
  end

  def match_result(result)
    case result
    in Success(user:)
      "Hello #{user.name}"
    in Failure(reason: :invalid_name)
      "Invalid name"
    in Failure(reason: :invalid_email)
      "Invalid email"
    end
  end

  def test_success
    message = match_result(CreateUser[attributes: {name: "Stephann", email: "stephann@example.com"}])

    assert_equal message, "Hello Stephann"
  end

  def test_no_name
    message = match_result(CreateUser[attributes: {name: nil, email: "stephann@example.com"}])

    assert_equal message, "Invalid name"
  end

  def test_no_email
    message = match_result(CreateUser[attributes: {name: "Stephann", email: nil}])

    assert_equal message, "Invalid email"
  end
end
