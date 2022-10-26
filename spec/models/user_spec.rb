require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    it "is not valid if password and confirmation don't match" do
      user_params = {
        name: 'Test',
        email: 'test@test.com',
        password: '1234',
        password_confirmation: '1235'
      }
      @user = User.new(user_params)
      expect(@user).to be_invalid
    end

    it "is not valid if password and confirmation are empty" do
      user_params = {
        name: 'Test',
        email: 'test@test.com'
      }
      @user = User.new(user_params)
      expect(@user).to be_invalid
    end

    it "is not valid if email is missing" do
      user_params = {
        name: 'Test',
        password: '1234',
        password_confirmation: '1234'
      }
      @user = User.new(user_params)
      expect(@user).to be_invalid
    end

    it "is not valid if name is missing" do
      user_params = {
        email: 'test@test.com',
        password: '1234',
        password_confirmation: '1234'
      }
      @user = User.new(user_params)
      expect(@user).to be_invalid
    end

    it "is invalid if email is not unique" do
      user1 = User.create(name: 'Test', email: 'test@test.com', password: '1234', password_confirmation: '1234')
      user2 = User.create(name: 'Test', email: 'TEST@TEST.com', password: '1234', password_confirmation: '1234')

      expect(user2.errors.full_messages).to include (/Email/)
    end

    it "is invalid if password is less than 4 characters long" do
      user_params = {
        name: 'Test',
        email: 'test@test.com',
        password: '123',
        password_confirmation: '123'
      }
      @user = User.new(user_params)
      expect(@user).to be_invalid
    end

  end

  describe '.authenticate_with_credentials' do
    
    it "should authenticate valid user" do
      @user = User.create(name: 'Test', email: 'test@test.com', password: '1234', password_confirmation: '1234')
      authenticated = User.authenticate_with_credentials('test@test.com', '1234')
      expect(authenticated).to be_present
      expect(authenticated).to be_truthy
    end

    it "should authenticate valid user with whitespace in email" do
      @user = User.create(name: 'Test', email: 'test@test.com', password: '1234', password_confirmation: '1234')
      authenticated = User.authenticate_with_credentials('test@test.com   ', '1234')
      expect(authenticated).to be_present
      expect(authenticated).to be_truthy
    end

    it "should authenticate valid user with wrong casing in email" do
      @user = User.create(name: 'Test', email: 'test@test.com', password: '1234', password_confirmation: '1234')
      authenticated = User.authenticate_with_credentials('teST@TEst.com', '1234')
      expect(authenticated).to be_present
      expect(authenticated).to be_truthy
    end
  end
end
