require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'is valid' do
    user = User.new(name: 'alex', email: 'alex2@example.com', password: 'secret', password_confirmation: 'secret')
    assert user.valid?
  end

  test 'is invalid without a name' do
    user = User.new(email: 'alex2@example.com')
    refute user.valid?
    assert_not_nil user.errors[:name]
  end

  test 'is invalid without an email' do
    user = User.new(name: 'alex')
    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test 'is invalid with an email of an existing user' do
    user = User.new(name: 'alex', email: users(:one).email, password: 'secret', password_confirmation: 'secret')
    refute user.valid?
    assert_not_nil user.errors[:email]
  end
end
